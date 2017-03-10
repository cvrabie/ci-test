#!/usr/bin/env bash

# define some colors to use for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# kill and remove any running containers
cleanup () {
  printf "Cleanig up docker\n"
  docker-compose -p ci kill
  docker-compose -p ci rm -f -v
}

cleanup

# catch unexpected failures, do cleanup and output an error message
trap 'cleanup ; printf "${RED}Tests Failed For Unexpected Reasons${NC}\n"'\
  HUP INT QUIT PIPE TERM

# build and run the composed services
docker-compose -p ci build && docker-compose -p ci up -d --force-recreate

docker-compose ps 

# output the logs for the test (for clarity)
#docker logs ci_microservice_1 | bunyan
#docker logs ci_integration-tester_1

# wait for the test service to complete and grab the exit code
printf "Waiting for tests to finish...\n"
TEST_EXIT_CODE=`docker wait ci_integration-tester_1`

docker logs ci_integration-tester_1

if [ $? -ne 0 ] ; then
  printf "${RED}Docker Compose Failed${NC}\n"
  exit -1
fi

# inspect the output of the test and display respective message
if [ -z ${TEST_EXIT_CODE+x} ] || [ "$TEST_EXIT_CODE" -ne 0 ] ; then
  printf "${RED}Tests Failed${NC} - Exit Code: $TEST_EXIT_CODE\n"
else
  printf "${GREEN}Tests Passed${NC}\n"
fi

# call the cleanup fuction
cleanup

# exit the script with the same code as the test service code
exit $TEST_EXIT_CODE


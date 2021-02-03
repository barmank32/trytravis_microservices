#!/bin/sh

# Use built-in Travis variables to check if all previous steps passed:
if [ $TRAVIS_TEST_RESULT -ne 0 ]; then
    build_status="errored"
    p_color="#c41e3a"
else
    build_status="passed"
    p_color="#2e8b57"
fi

p_username="Travis CI WebHook"
p_text="
Build <${TRAVIS_JOB_WEB_URL}|#${TRAVIS_BUILD_NUMBER}>
of ${TRAVIS_REPO_SLUG}@${TRAVIS_BRANCH}
*${build_status}!*"

curl -s -X POST --data-urlencode "payload={\"username\":\"${p_username}\",\"color\":\"${p_color}\",\"fields\":[{\"value\":\"${p_text}\",\"short\":false}]}" ${WEBHOOK_URL}

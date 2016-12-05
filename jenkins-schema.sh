#!/bin/bash

export INITIATING_REPO_NAME="alphagov/govuk-content-schemas"
export CONTEXT_MESSAGE="Verify multipage-frontend against content schemas"

exec ./jenkins.sh

#!/bin/bash
#######################################################################
# Author  : Muskan
# Date    : 10-10-2004
# Version : v1
#
# Description:
#   Reports AWS resource usage (S3, EC2, Lambda, IAM) and saves it
#   to a dated report file in the ../reports folder.
#
# Prerequisites:
#   - AWS CLI installed and configured (aws configure)
#   - jq installed
#
# Usage:
#   ./scripts/aws_resource_tracker.sh
#   DEBUG=1 ./scripts/aws_resource_tracker.sh   # debug mode (set -x)
#######################################################################

# Exit on error (-e), on undefined variable (-u), and on pipe failures
set -euo pipefail

# Optional debug mode: prints every command as it runs
if [ "${DEBUG:-0}" = "1" ]; then
    set -x
fi

# Report file goes into ../reports, named with today's date
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPORT_DIR="$SCRIPT_DIR/../reports"
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/resource_report_$(date +%F).txt"

# Check that required tools exist
for tool in aws jq; do
    if ! command -v "$tool" > /dev/null 2>&1; then
        echo "Error: '$tool' is not installed." >&2
        exit 1
    fi
done

{
    echo "=============================================="
    echo " AWS Resource Usage Report - $(date '+%F %T')"
    echo "=============================================="
    echo

    # List S3 buckets
    echo "--- S3 Buckets ---"
    aws s3 ls
    echo

    # List EC2 instance IDs (jq extracts only the InstanceId from the JSON)
    echo "--- EC2 Instances (IDs) ---"
    aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId'
    echo

    # List Lambda functions
    echo "--- Lambda Functions ---"
    aws lambda list-functions | jq -r '.Functions[].FunctionName'
    echo

    # List IAM users
    echo "--- IAM Users ---"
    aws iam list-users | jq -r '.Users[].UserName'
    echo
} > "$REPORT_FILE"

echo "Report saved to: $REPORT_FILE"

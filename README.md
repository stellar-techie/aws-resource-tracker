# AWS Resource Tracker

A lightweight AWS resource inventory tool built using **Bash scripting and the AWS CLI**. It collects information about selected AWS resources and generates a timestamped report for easy review.

## Overview

Managing cloud resources becomes easier when you can view important resource information in one report. This project automates the collection of basic AWS resource details using command-line tools.

The script retrieves information about:

- **Amazon S3:** Lists S3 buckets.
- **Amazon EC2:** Lists EC2 instance IDs.
- **AWS Lambda:** Lists Lambda function names.
- **AWS IAM:** Lists IAM usernames.

The collected information is saved to a dated text report.

## Tech Stack

- **Bash:** Shell scripting and automation
- **AWS CLI:** Interacting with AWS services
- **jq:** Extracting fields from JSON responses
- **Linux cron:** Optional scheduled execution

## Project Structure

```text
aws-resource-tracker/
├── scripts/
│   └── aws_resource_tracker.sh
├── reports/
│   └── sample_resource_report.txt
├── .gitignore
├── crontab.example
└── README.md
```

The `reports/` directory is used to store generated reports. The included sample report is illustrative and is not evidence of a verified live AWS execution.

## Prerequisites

Before running the script, make sure you have:

1. AWS CLI installed.
2. AWS CLI credentials configured for your AWS account.
3. Bash available in your environment, such as Linux, macOS, or WSL on Windows.
4. `jq` installed.
5. An AWS identity with the required read permissions.

Configure the AWS CLI using your own credentials:

```bash
aws configure
```

Verify that your AWS identity is configured:

```bash
aws sts get-caller-identity
```

Use an appropriately scoped IAM identity. The script needs permission to list S3 buckets, describe EC2 instances, list Lambda functions, and list IAM users.

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/YOUR-USERNAME/aws-resource-tracker.git
cd aws-resource-tracker
```

Replace `YOUR-USERNAME` with your GitHub username.

### 2. Make the script executable

```bash
chmod +x scripts/aws_resource_tracker.sh
```

### 3. Run the script

```bash
./scripts/aws_resource_tracker.sh
```

The script creates a report in the `reports/` directory with a filename based on the current date.

Example filename:

```text
resource_report_YYYY-MM-DD.txt
```

The script requires AWS CLI access and the necessary permissions to retrieve resource information.

## Sample Report

The generated report follows this general format:

```text
==============================================
 AWS Resource Usage Report - YYYY-MM-DD HH:MM:SS
==============================================

--- S3 Buckets ---
<bucket names>

--- EC2 Instances (IDs) ---
<instance IDs>

--- Lambda Functions ---
<function names>

--- IAM Users ---
<usernames>
```

The actual output depends on the AWS account, configured region where applicable, available resources, and permissions.

## Debugging

To enable Bash execution tracing for troubleshooting:

```bash
DEBUG=1 ./scripts/aws_resource_tracker.sh
```

This helps identify which commands are being executed. Be careful when sharing debug output because command output may contain account or resource information.

## Optional: Schedule Automated Execution

The repository includes `crontab.example`, which demonstrates how to schedule the script using Linux cron.

To configure a schedule:

```bash
crontab -e
```

Update the example command with the actual script path and an appropriate log path before using it.

The example schedules execution daily at 6 PM. Cron is optional; the script can also be run manually.

## Security Considerations

- Never commit AWS access keys, secret keys, passwords, or private credentials.
- Prefer IAM roles or other secure credential mechanisms when available.
- Grant only the permissions required for the intended operations.
- Review reports before sharing them publicly because resource names and identifiers may be sensitive.
- Keep generated reports and logs out of version control when they contain real account information.

## Current Scope and Limitations

This project currently focuses on **resource inventory and reporting**.

It does not currently calculate AWS costs, identify idle resources, detect unattached EBS volumes, or automatically delete resources. Those features could be explored as future improvements.

## Future Improvements

- Add support for additional AWS resource types.
- Include resource metadata such as EC2 instance states.
- Add error handling and clearer reporting for individual AWS service failures.
- Introduce resource filtering and region selection.
- Explore cost reporting using appropriate AWS billing APIs.
- Add automated testing and continuous integration.

## Learning Outcomes

This project provides practical experience with:

- Bash scripting and command-line automation
- AWS CLI commands and service interaction
- Parsing JSON output using `jq`
- File redirection and report generation
- Debugging scripts and scheduling tasks with cron
- Basic cloud resource inventory practices

## Disclaimer

This is a learning project intended for educational use. Review the script and permissions before running it against an AWS account. Actual execution and AWS resource access depend on your environment and configuration.

## Author

**MUSKAN**

GitHub: [stellar-techie](https://github.com/stellar-techie)

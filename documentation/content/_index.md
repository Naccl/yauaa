+++
title = "Yauaa: Yet Another UserAgent Analyzer"
linkTitle = "Yauaa"
+++
# Yauaa: Yet Another UserAgent Analyzer
This is a java library that tries to parse and analyze the useragent string and extract as many relevant attributes as possible.

The full documentation can be found here [https://yauaa.basjes.nl](https://yauaa.basjes.nl)

## HIGH Profile release notes:
### Version 6.1
---
- Support for the new `reduced` User-Agent as is being implemented in Google Chrome/Chromium.
- Improved User Defined Function for Apache Beam SQL.
- Detect the first car based browsers. DeviceClass = Car

### Version 6.0
---
- Fully replaced SLF4J with Log4J2; since this is a breaking change the next version will be 6.0
- Dropping the native commandline version. Using the webservlet locally with curl is a lot faster.

## Donations
If this project has business value for you then don't hesitate to support me with a small donation.

[![Donations via PayPal](https://img.shields.io/badge/Donations-via%20Paypal-blue.svg)](https://www.paypal.me/nielsbasjes)

## License

    Yet Another UserAgent Analyzer
    Copyright (C) 2013-2021 Niels Basjes

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
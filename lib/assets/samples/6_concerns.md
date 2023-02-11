# Domain concern
{{id: concern, parent: root}}

- Mergers and acquisitions
- Time to market
- User satisfaction
- Competitive advantage
- Time and budget

## Architecture Characteristics

Also known as "quality characteristics" or "non-functional requirements"

Domain Concern           Architecture characteristics
------------------------ -----------------------------
Mergers and acquisitions Interoperability, scalability, adaptability, extensibility
Time to market           Agility, testability, deployability
User satisfaction        Performance, availability, fault tolerance, testability, deployability, agility, security
Competitive advantage    Agility, testability, deployability, scalability, availability, fault tolerance
Time and budget          Simplicity, feasibility

### Operational

Term               Definition
------------------ ---------------------------
Availability       How long the system will need to be available (if 24/7, steps need to be in place to allow the system to be up and running quickly in case of any failure).
Continuity         Disaster recovery capability.
Performance        Includes stress testing, peak analysis, analysis of the frequency of functions used, capacity required, and response times. Performance acceptance sometimes requires an exercise of its own, taking months to complete.
Recoverability     Business continuity requirements (e.g., in case of a disaster, how quickly is the system required to be online again?). This will affect the backup strategy and requirements for duplicated hardware.
Reliability/safety Assess if the system needs to be fail-safe, or if it is mission critical in a way that affects lives. If it fails, will it cost the company large sums of money?
Robustness         Ability to handle error and boundary conditions while running if the internet connection goes down or if there’s a power outage or hardware failure.
Scalability        Ability for the system to perform and operate as the number of users or requests increases

### Structural

Term                  Definition
--------------------- ----------
Configurability       Ability for the end users to easily change aspects of the software’s configuration (through usable interfaces).
Extensibility         How important it is to plug new pieces of functionality in.
Installability        Ease of system installation on all necessary platforms.
Leverageability/reuse Ability to leverage common components across multiple products.
Localization          Support for multiple languages on entry/query screens in data fields; on reports, multibyte character requirements and units of measure or currencies.
Maintainability       How easy it is to apply changes and enhance the system?
Portability           Does the system need to run on more than one platform? (For example, does the frontend need to run against Oracle as well as SAP DB?
Supportability        What level of technical support is needed by the application? What level of logging and other facilities are required to debug errors in the system?
Upgradeability        Ability to easily/quickly upgrade from a previous version of this application/solution to a newer version on servers and clients

### Cross-cutting

Term           Definition
-------------- ------------------------------
Accessibility  Access to all your users, including those with disabilities like colorblindness or hearing loss.
Archivability  Will the data need to be archived or deleted after a period of time? (For example, customer accounts are to be deleted after three months or marked as obsolete and archived to a secondary database for future access.)
Authentication Security requirements to ensure users are who they say they are.
Authorization  Security requirements to ensure users can access only certain functions within the application (by use case, subsystem, webpage, business rule, field level, etc.).
Legal          What legislative constraints is the system operating in (data protection, Sarbanes Oxley, GDPR, etc.)? What reservation rights does the company require? Any regulations regarding the way the application is to be built or deployed?
Privacy        Ability to hide transactions from internal company employees (encrypted transactions so even DBAs and network architects cannot see them).
Security       Does the data need to be encrypted in the database? Encrypted for network communication between internal systems? What type of authentication needs to be in place for remote user access?
Supportability What level of technical support is needed by the application? What level of logging and other facilities are required to debug errors in the system?
Usability      Level of training required for users to achieve their goals with the application/solution.

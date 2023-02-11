% Requirements (BABOK)

# Classification

__Business requirements__: statements of goals, objectives, and outcomes that describe why a change has been initiated. They can apply to the whole of an enterprise, a business area, or a specific initiative.

__Stakeholder requirements__: describe the needs of stakeholders that must be met in order to achieve the business requirements. They may serve as a bridge between business and solution requirements

__Solution requirements__ : describe the capabilities and qualities of a solution that meets the stakeholder requirements. They provide the appropriate level of detail to allow for the development and implementation of the solution. Solution requirements can be divided into two sub-categories:

* __Functional requirements__: describe the capabilities that a solution must have in terms of the behaviour and information that the solution will manage, and
* __Non-functional requirements or quality of service requirements__: do not relate directly to the behaviour of functionality of the solution, but rather describe conditions under which a solution must remain effective or qualities that a solution must have.

__Transition requirements__: describe the capabilities that the solution must have and the conditions the solution must meet to facilitate transition from the current state to the future state, but which are not needed once the change is complete. They are differentiated from other requirements types because they are of a temporary nature. Transition requirements address topics such as data conversion, training, and business continuity.

# Life cycle

The purpose is to ensure that business, stakeholder, and solution requirements and designs are aligned to one another and that the solution implements them.

@@list

## Trace  

Business Needs <-> Business Requirements <-> Stakeholder Requirements <-> Solution Requirements (Design <-> Code <-> Test)

## Maintain

The purpose is to retain requirement accuracy and consistency throughout and beyond the change during the entire requirements life cycle, and to support reuse of requirements in other solutions.

## Prioritize

Typical factors that influence prioritization include:

__Benefit__ the advantage that accrues to stakeholders as a result of requirement implementation, as measured against the goals and objectives for the change. The benefit provided can refer to a specific functionality, desired quality, or strategic goal or business objective. If there are multiple stakeholders, each group may perceive benefits differently. Conflict resolution and negotiation may be employed to come to consensus on overall benefit.

__Penalty__ the consequences that result from not implementing a given requirement. This includes prioritizing requirements in order to meet regulatory or policy demands imposed on the organization, which may take precedence over other stakeholder interests. Penalty may also refer to the negative consequence of not implementing a requirement that improves the experience of a customer.

__Cost__ the effort and resources needed to implement the requirement. Information about cost typically comes from the implementation team or the vendor. Customers may change the priority of a requirement after learning the cost. Cost is often used in conjunction with other criteria, such as cost-benefit analysis.

__Risk__ the chance that the requirement cannot deliver the potential value, or cannot be met at all. This may include many factors such as the difficulty of implementing a requirement, or the chance that stakeholders will not accept a solution component. If there is a risk that the solution is not technically feasible, the requirement that is most difficult to implement may be prioritized to the top of the list in order to minimize the resources that are spent before learning that a proposed solution cannot be delivered. A proof of concept may be developed to establish that high risk options are possible.

__Dependencies__ relationships between requirements where one requirement cannot be fulfilled unless the other requirement is fulfilled. In some situations, it may be possible to achieve efficiencies by implementing related requirements at the same time. Dependencies may also be external to the initiative, including but not limited to other teams’ decisions, funding commitments, and resource availability. Dependencies are identified as part of the task Trace Requirements (p. 79).

__Time Sensitivity__ the 'best before' date of the requirement, after which the implementation of the requirement loses significant value. This includes time-to-market scenarios, in which the benefit derived will be exponentially greater if the functionality is delivered ahead of the competition. It can also refer to seasonal functionality that only has value at a specific time of year.

__Stability__ the likelihood that the requirement will change, either because it requires further analysis or because stakeholders have not reached a consensus about it. If a requirement is not stable, it may have a lower priority in order to minimize unanticipated rework and wasted effort.

__Regulatory or Policy Compliance__ requirements that must be implemented in order to meet regulatory or policy demands imposed on the organization, which may take precedence over other stakeholder interests.

## Assess changes

The purpose is to evaluate the implications of proposed changes to requirements and designs. The task is performed as new needs or possible solutions are identified.

* is it align to the change strategy and/or solution scope?
* will increase the value of the solution?
* has conflicts with other requirements?
* or increase the level of risk?
* can be traced back to a need?

## Approve

The purpose is to obtain agreement on and approval of requirements and designs for business analysis work to continue and/or solution construction to proceed.

Business analysts are responsible for ensuring clear communication of requirements, designs, and other business analysis information to the key stakeholders responsible for approving that information.

Approval of requirements and designs may be formal or informal. Predictive approaches typically perform approvals at the end of the phase or during planned change control meetings. Adaptive approaches typically approve requirements only when construction and implementation of a solution meeting the requirement can begin.

Business analysts work with key stakeholders to gain consensus on new and changed requirements, communicate the outcome of discussions, and track and manage the approval.

# Quality

While quality is ultimately determined by the needs of the stakeholders who will use the requirements or the designs, acceptable quality requirements exhibit many of the following characteristics:

Quality        Definition
-------------- ----------
Atomic         self-contained and capable of being understood independently of other requirements or designs.
Complete       enough to guide further work and at the appropriate level of detail for work to continue. The level of completeness required differs based on perspective or methodology, as well as the point in the life cycle where the requirement is being examined or represented.
Consistent     aligned with the identified needs of the stakeholders and not conflicting with other requirements.
Concise        contains no extraneous and unnecessary content.
Feasible       reasonable and possible within the agreed-upon risk, schedule, and budget, or considered feasible enough to investigate further through experiments or prototypes.
Unambiguous the requirement must be clearly stated in such a way to make it clear whether a solution does or does not meet the associated need.
Testable       able to verify that the requirement or design has been fulfilled. Acceptable levels of verifying fulfillment depend on the level of abstraction of the requirement or design.
Prioritized    ranked, grouped, or negotiated in terms of importance and value against all other requirements.
Understandable represented using common terminology of the audience.

# Attributes

Attribute                Definition
------------------------ ----------------------
rationale                a justification
originator               who raised
fit criterion            how to test if the solution matches the requirement
customer satisfaction    if this requirement is successfully implemented; 1-5, uninterested - extremely pleased
customer dissatisfaction measure of stakeholders unhappiness if this requirements is not part of the final product. 1-5, hardly matters - extremely displeased
conflict
complexity
effort
risk
priority
derived                  when a requirement is derived from another requirement
depends                  when a requirement depends on another
necessity                when it only makes sense to implement a particular requirement if a related requirement is also implemented.
lower effort             when a requirement is easier to implement if a related requirement is also implemented.
satisfy                  an implementation element, eg functional requirement satisfy a solution component
validate                 a test case that can determine whether a solution fulfills the requirement

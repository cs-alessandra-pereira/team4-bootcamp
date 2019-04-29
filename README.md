# Team4 - Bootcamp

# Refactoring for a clean architecture

## Part I

_The goal of software architecture is to minimize the human resouces required to build and maintain the required system._

### Behavior vs architecture

Stakeholder's requirements change. It's a fact.
_soft-ware_: a way to easily change the behavior of machines.
So software must be easy to change. Architecture should facilitate changes.

- If you give me a program that works perfectly but is impossible to change, 
then it won't work when the requirements change, and I won't be able to make it work.
Therefore the program will become useless.

- If you give me a program that dows not work but is easy to change, then I can make il work, 
and keep it working as requirements change. Therefore the program will remain continually useful.

### Importance versus urgency.

Sofware:
- _behavior_ -> urgent
- _architecture_ -> important

Priority:
1. Urgent and important
2. Not urgent and important
3. Urgent and not important
4. Not urgent and not important

Important stuff is in the top two positions!
Common mistake: elevate items in position 3 to position 1.

Is the responsibility of the software development team to assert the importance of architecture over the urgency of features.

### Fight for the architecture

If the architecture comes last, then the system will become even more costly to develop, and eventually cheange will become practically impossible for part or alla of the system.

### Explanation of the Project and Documentation

This project, **Project Conversation History**, was built as part of a task where we needed to create a conversation history feature for projects using **Ruby on Rails**. The application allows users to leave comments on projects and change the status of the project. The project was developed with the goal of showcasing good coding practices, adaptability, and a clear focus on clean architecture and maintainability.

#### Wiki Links
We have created several helpful wikis to document the project thoroughly and explain the design choices. You can explore them here:
- [**Welcome to the homey wiki!**](https://github.com/hdkhosravian/homey/wiki/Welcome-to-the-homey-wiki!-(Questions-and-expected-answers))  
  This section covers the questions we would have asked before starting the task, along with expected answers. It includes clarifications on the features, business requirements, and assumptions made based on the brief provided. This allowed us to stay aligned with the project’s objectives.
  
- [**Project Overview: Project Conversation History Application**](https://github.com/hdkhosravian/homey/wiki/Project-Overview:-Project-Conversation-History-Application)  
  This document provides a complete overview of the architecture, explaining the models, relationships, design patterns used, and the gems that power this project. We have also covered how the workflow progresses and why each design choice was made.

- [**Project Conversation History ‐ Feature Documentation**](https://github.com/hdkhosravian/homey/wiki/Project-Conversation-History-%E2%80%90-Feature-Documentation)  
  This page describes the core functionality and features that we implemented, such as how users can leave comments, change the project’s status, and track notifications for important changes. This documentation also explains the business logic and how certain features are implemented from the user’s perspective.

---

### **Design Patterns and Principles**

In this project, we prioritized **SOLID principles** and best practices to ensure the code remains scalable and maintainable as new features are added. 

#### **Why SOLID Principles?**
By adhering to SOLID principles, we make sure that:
- **Single Responsibility Principle (SRP)**: Each part of the application handles only one aspect of the logic, which makes the code easier to understand and maintain.
- **Open/Closed Principle**: We ensured that the code is open for extension but closed for modification, by using **services** to manage business logic and **Pundit** for authorization.
- **Dependency Inversion Principle**: We used **Service Objects** with the **ActiveInteraction** gem to manage complex business logic. This helps separate concerns and keeps the models lean.

#### **Service Objects with ActiveInteraction**
We leveraged the **Service Object pattern** using the **ActiveInteraction** gem. This helped encapsulate complex business logic (like creating and updating projects or comments) into their own service classes, promoting cleaner and more modular code. The benefit here is that:
- Models are kept free from business logic.
- The system becomes more maintainable since each service handles a specific operation, and changes in one service don't affect others.

For example:
- We created a `Projects::CreateService` that handles the logic for creating a project.
- A similar approach was used for updating the project, managing comments, and creating status changes.

#### **Adapter Pattern (Future Integration)**
Although not yet implemented, we structured the project in such a way that it can easily integrate with external services (e.g., sending notifications to Slack or integrating with project management tools like Jira). By using the **Adapter Pattern**, we could add these integrations without modifying the core application logic, keeping it open for extension but closed for modification.

#### **Pundit for Authorization**
We used **Pundit** to manage authorization across the application. Pundit ensures that users only have access to the actions they are permitted to perform. For instance, only the project owner can update or delete projects, while all users can leave comments or view notifications.

---

### **Why These Decisions?**

The design choices made in this project are focused on scalability, maintainability, and clean separation of concerns. Given the time constraint of the task (3 hours), we focused on developing an MVP that demonstrates:
1. **Good Architecture**: By utilizing **service objects**, **Pundit**, and **SOLID principles**, we ensured that the code is organized, maintainable, and adaptable for future changes.
2. **User Interaction**: The application allows users to:
    - Create and update projects.
    - Comment on projects and view comments.
    - Change the project status and track the history of changes.
    - View notifications when comments or status changes occur.
3. **Test Coverage**: The project has been tested using **RSpec** to ensure that all the main features (projects, comments, status changes, and notifications) function correctly and as expected.

---

### **Gem Choices**

- **Devise**: We used **Devise** to implement user authentication. This gem allows us to quickly and securely manage user logins, sign-ups, and sessions with minimal configuration, ensuring robust security and easy management of user data.
  
- **Pundit**: **Pundit** was chosen for its simplicity and effectiveness in managing authorization across the app. It provides a clean way to manage who can perform specific actions, ensuring that the app respects different user roles.

- **ActiveInteraction**: We implemented **ActiveInteraction** to handle business logic cleanly through service objects. Instead of bloating the models with logic, we used service classes to encapsulate the logic for creating, updating, and managing projects, comments, and status changes.

- **TailwindCSS**: **TailwindCSS** was used for the front-end styling. Tailwind's utility-first CSS framework allows for rapid UI development, keeping the design simple yet flexible. It ensures that the UI is responsive and easily customizable.

- **RSpec**: We added **RSpec** to ensure the application is well-tested. This includes model tests, service object tests, policy tests (for Pundit), and controller tests. Testing guarantees that the core features work as expected and the app is more stable and reliable.

---

### **User Workflow and How the App Works**

1. **User Authentication**: Users sign in or sign up via the **Devise** system. Authentication ensures that only authorized users can interact with the app.
  
2. **Creating and Managing Projects**: Once authenticated, users can create projects. Each project has its own conversation history, which includes comments and status changes. Only the project owner has the ability to edit the project’s details or delete it.

3. **Adding Comments**: Any user can leave comments on a project. Comments provide a space for collaboration and communication. A user can comment as much as they want, and each comment is tied to the project and the user.

4. **Changing Project Status**: The project owner can update the status of the project using predefined statuses like `not_started`, `in_progress`, `completed`. Each status change is tracked, and a notification is created to keep all users informed of the updates.

5. **Viewing Notifications**: Notifications inform users about status changes or new comments. This helps users stay updated about the progress of the project.

---

### Conclusion

This project was designed to showcase best practices in Ruby on Rails development, focusing on a modular and maintainable codebase. The use of **SOLID principles**, **service objects**, and **Pundit** ensures the system is scalable and flexible for future features. The **Project Conversation History** feature allows users to manage projects, comment on them, and track status changes while staying informed through notifications.

Feel free to visit the detailed wikis for more information:
- [Welcome to the homey wiki! (Questions and expected answers)](https://github.com/hdkhosravian/homey/wiki/Welcome-to-the-homey-wiki!-(Questions-and-expected-answers))
- [Project Overview: Project Conversation History Application](https://github.com/hdkhosravian/homey/wiki/Project-Overview:-Project-Conversation-History-Application)
- [Project Conversation History ‐ Feature Documentation](https://github.com/hdkhosravian/homey/wiki/Project-Conversation-History-%E2%80%90-Feature-Documentation)


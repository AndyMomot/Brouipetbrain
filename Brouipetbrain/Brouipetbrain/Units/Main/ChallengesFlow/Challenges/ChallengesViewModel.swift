//
//  ChallengesViewModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 22.11.2024.
//

import Foundation

extension ChallengesView {
    final class ViewModel: ObservableObject {
        @Published var currentPageIndex = 0
        let challenges: [ChallengeModel] = [
            .init(
                id: 0,
                title: "Building a Multi-Container Application Using Docker and Docker Compose",
                description: "Create an application with multiple microservices (e.g., frontend, backend, and database) using Docker and Docker Compose. Each service should run in its own container.",
                goal: " Understand the principles of containerization, working with Docker and Docker Compose."
            ),
            .init(
                id: 1,
                title: "Implementing a CI/CD Pipeline",
                description: "Set up a complete continuous integration and continuous delivery (CI/CD) pipeline for your project using Jenkins, GitLab CI, or GitHub Actions.",
                goal: "Learn automation of builds, testing, and deployment using popular CI/CD tools."
            ),
            .init(
                id: 2,
                title: "Developing a RESTful API Using Python (Django/Flask) or Node.js (Express)",
                description: "Create a RESTful API for a simple web application (e.g., a task manager, blog, or inventory system).",
                goal: "Understand the principles of API development, handling requests and responses, and interacting securely with a database."
            ),
            .init(
                id: 3,
                title: "Optimizing Database Performance",
                description: "Take an existing database (SQL or NoSQL) and perform query optimization, indexing, caching, and other techniques to improve performance.",
                goal: "Gain experience working with databases, query optimization, and performance tuning."
            ),
            .init(
                id: 4,
                title: "Developing Algorithms for Big Data Processing",
                description: "Write an algorithm in Python or another language to process and analyze large datasets (e.g., parsing large files or implementing sorting/searching algorithms).",
                goal: "Learn to work with big data, optimize algorithms, and handle large-scale data efficiently."
            ),
            .init(
                id: 5,
                title: "Implementing Authentication and Authorization in a Web Application",
                description: "Develop a user authentication and authorization system for a web application, using tokens (JWT) or OAuth.",
                goal: "Understand security basics, user management, and implementing secure authentication mechanisms."
            ),
            .init(
                id: 6,
                title: "Setting Up a Server Monitoring System",
                description: "Set up a server monitoring system using tools like Prometheus, Grafana, or the ELK stack (Elasticsearch, Logstash, Kibana).",
                goal: "Gain experience in server monitoring, tracking server health, and analyzing logs."
            ),
            .init(
                id: 7,
                title: "Deploying an Application in the Cloud (AWS, Azure, GCP)",
                description: "Develop an application and deploy it in the cloud using platforms like AWS, Azure, or Google Cloud. Utilize basic services like EC2, S3, or Kubernetes.",
                goal: "Gain hands-on experience with cloud platforms, infrastructure as code, and managing cloud services."
            ),
            .init(
                id: 8,
                title: "Implementing a Microservices Architecture",
                description: "Build an application that uses a microservices architecture with multiple independent services communicating via APIs.",
                goal: "Understand microservices principles, inter-service communication via APIs, and managing distributed systems."
            ),
            .init(
                id: 9,
                title: "Developing an AI-powered Chatbot",
                description: "Build a chatbot to perform a specific task, using natural language processing (NLP) tools such as Rasa, Dialogflow, or OpenAI GPT.",
                goal: "Gain skills in AI, chatbot development, and natural language processing."
            ),
        ]
    }
}

struct ChallengeModel: Identifiable {
    var id: Int
    var title, description, goal: String
}

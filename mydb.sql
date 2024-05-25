
CREATE DATABASE construction_project;
USE construction_project;


CREATE TABLE projects (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          description TEXT,
                          start_date DATE,
                          end_date DATE,
                          budget DECIMAL(10, 2)
);


CREATE TABLE tasks (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       description TEXT,
                       start_date DATE,
                       end_date DATE,
                       status VARCHAR(20),
                       project_id INT,
                       FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);


CREATE TABLE resources (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           name VARCHAR(255) NOT NULL,
                           type VARCHAR(100),
                           quantity INT,
                           task_id INT,
                           FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
);

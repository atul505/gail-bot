-- 1. Create Database
CREATE DATABASE chatbot_db;
USE chatbot_db;

-- 2. Create `users` Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Create `chatbot_responses` Table
-- Updated to include `condition_type`
CREATE TABLE chatbot_responses (
    response_id INT PRIMARY KEY AUTO_INCREMENT,
    condition_type VARCHAR(50) NOT NULL,
    response_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 4. Create `active_sessions` Table
CREATE TABLE active_sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 5. Create `user_interactions` Table
CREATE TABLE user_interactions (
    interaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    interaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    trigger_phrase VARCHAR(255),
    response_text TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 6. Create `employees` Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    department VARCHAR(50),
    contact_info VARCHAR(100),
    hire_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 7. Create `leave_requests` Table
CREATE TABLE leave_requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    leave_start DATE,
    leave_end DATE,
    leave_type VARCHAR(50),
    status VARCHAR(20), -- e.g., Approved, Pending, Rejected
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 8. Create `office_timings` Table
CREATE TABLE office_timings (
    office_id INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(50),
    opening_time TIME,
    closing_time TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 9. Insert Sample Data into `chatbot_responses`
INSERT INTO chatbot_responses (condition_type, response_text) VALUES
('leave policies', 'Our leave policy includes 20 annual leaves, 10 sick leaves, and 5 casual leaves per year.'),
('general', 'Welcome to the HR chatbot! How can I assist you today?'),
('benefits', 'Our benefits package includes health insurance, a retirement savings plan, and performance bonuses.'),
('work hours', 'Our standard work hours are from 9 AM to 5 PM, Monday through Friday. Some departments may have different hours.'),
('remote work', 'We offer flexible remote work options. Please consult with your manager to discuss potential arrangements.'),
('employee handbook', 'You can access the employee handbook in the company portal or request a physical copy from HR.'),
('payroll schedule', 'Employees are paid bi-weekly. Payroll is processed every other Friday.'),
('training programs', 'We offer various training programs to help you develop your skills. Check the Learning & Development section on the intranet for more details.'),
('performance reviews', 'Performance reviews are conducted annually. Your manager will schedule a review meeting to discuss your performance and career development.'),
('vacation request', 'To request vacation time, please submit a request through the HR portal or contact your HR representative.'),
('sick leave', 'If you need to take sick leave, notify your manager and HR as soon as possible. A doctor''s note may be required for extended absences.'),
('employee referral program', 'Our employee referral program rewards employees who refer successful candidates for open positions. Contact HR for more details.');

-- 10. Insert Sample Data into `users`
INSERT INTO users (username, password_hash, first_name, last_name, email) VALUES
('Aditya', 'adityakrjha', 'Aditya', 'jha', 'jhaa8933@gmail.com'),
('Atul', 'Atul1234', 'Atul', 'Patel', 'atulk4360@gmail.com'),
('janmejay', 'singh1234', 'janmejay', 'singh', 'janmejaykumarsingh@gmail.com'),
('omkar', 'omkar1234', 'omkar', 'agarwaal', 'omkaraggarwaal00@gmail.com'),
('Riddhi', 'riddhi1234', 'riddhi', 'singh', 'singhriddhi237@gmail.com'),
('Rose', 'rose1234', 'rose', 'banga', 'rosebanga1306@gmail.com');

-- 11. Insert Sample Data into `employees`

INSERT INTO employees (employee_id, employee_name, position, contact_info, hire_date) VALUES
('1', 'Aditya', 'Database_manager', 'jhaa8933@gmail.com', '2006-07-09'),
('2', 'Atul', 'backend_developer', 'atulk4360@gmail.com', '2006-07-09'),
('3', 'Janmejay', 'backend_manager', 'janmejaykumarsingh@gmail.com', '2006-07-09'),
('4', 'Omkar', 'frontend_developer', 'omkaraggarwaal00@gmail.com', '2006-07-09'),
('5', 'Riddhi', 'frontend_manager', 'singhriddhi237@gmail.com', '2006-07-09'),
('6', 'Rose', 'Networking', 'rosebanga1306@gmail.com', '2006-07-09');



-- 13. Insert Sample Data into `office_timings`
INSERT INTO office_timings (department, opening_time, closing_time) VALUES
('Engineering', '09:00:00', '17:00:00'),
('Human Resources', '09:00:00', '17:00:00');

-- 14. Sample Login Validation Query
-- Replace 'input_username' and 'hashed_input_password' with actual values
SELECT user_id FROM users
WHERE username = 'input_username' AND password_hash = 'hashed_input_password';

-- 15. Check Number of Active Sessions
SELECT COUNT(*) AS active_users FROM active_sessions;

-- 16. Insert New Session (if valid and less than 5 active sessions)
INSERT INTO active_sessions (user_id) VALUES ('user_id_from_previous_query');

-- 17. Log User Interaction
-- This can be used to log each interaction for tracking or analytics
INSERT INTO user_interactions (user_id, trigger_phrase, response_text) VALUES
('user_id_from_previous_query', 'hello', 'Hi there! How can I assist you today?');

-- 18. Delete Session (during logout)
DELETE FROM active_sessions WHERE user_id = 'user_id';

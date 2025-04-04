## [Read.me [Japanese .ver]](https://sonmyeongjin.github.io/posts/Server-readme-_-JPN/)
## [Read.me [Korean .ver]](https://sonmyeongjin.github.io/posts/Server-readme-_-Kor/)

# Project Overview
This project is a blog platform implemented using Ruby on Rails and Vue.js. It includes features such as user authentication, article management, and search filtering.

[Client Github](https://github.com/SonMyeongJin/DataX_Project_Client)

[API Deployed]
~~http://43.203.118.99:3000/~~
(2025.04.03 closed)
- Requests are received via HTTP, and responses are returned in JSON format within the HTTP Body.

## Development Environment
- Development Environment: macOS
- Ruby 3.2.6
- Rails 7.2.2.1
- Database: MySQL 9.2.0
- Deployment: AWS EC2

# Project Setup Steps

- Install Project Environment
    - Install Ruby 3.2.6
    - Install Bundler
    - Install Database (MySQL)
    - Install Rails

- Development Flow
    1. Create ERD
        - ![](/ReadmeSrc/datax_erd.png)
    2. Connect Rails project to MySQL database
    3. Define Models based on ERD (Attributes)
    4. Write API Specification
        - ### [Notion API URL](https://son-myeongjin.notion.site/datax-project-api?v=1aa07b1a3de181e38b81000cf2237f46)
        - ![](/ReadmeSrc/datax_notion.png)
    5. Implement Login Functionality with JWT Token
        - Use the Devise library in Rails.
    6. Implement Post Creation, Deletion, and Editing Logic
    7. Implement Tag Functionality
    8. Deploy via AWS
    9. Integrate with Vue Client

# Implemented Features

- User Registration
    - Accepts name, email, and password as input.
    - Upon successful registration, stores name, email, and password in the database.
    - Response: name, email, creation date, and user ID
      (User ID is used later to verify ownership when editing or deleting posts.)

- Login & Logout Functionality
    - Login Feature
        - Accepts email and password, verifies credentials in the database.
        - Returns a token upon successful login.
        - This token must be included in the HTTP Header for access to certain features (e.g., creating posts, logging out, etc.).
    - Logout Feature (Token Required)
        - Verifies the token and, if logged in, returns a logout confirmation message.
        - The system identifies the JTI value of the token to reject any future requests made with the logged-out token.

- Posting Feature (Token Required)
    - Create Post
    - Delete Post
    - Edit Post
    - Get Post List

- Tag Functionality
    - Create Tags
      - Tags can be added when creating a post.
      - If a tag already exists, it returns the existing ID; otherwise, it assigns a new ID and returns it.

    - Filtering with Tags
      - If a GET request includes a tag ID, it returns an array of posts with the same tag.

    - ![](/ReadmeSrc/datax_tag.jpeg)

# Key Enhancements
- Security Enhancement with JTI for Login
  - Using only JWT tokens for login allows access even after logging out, as the token remains valid. Therefore, JTI was implemented to ensure the JWT token can be rejected, adding an extra layer of security.

- ![](/ReadmeSrc/datax_login.jpeg)

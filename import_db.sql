PRAGMA foreign_keys = ON;




DROP TABLE question_likes;
DROP table replies;
DROP table question_follows;
DROP TABLE questions;
DROP TABLE users;

CREATE Table users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NUll
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT UNIQUE,
  body TEXT ,
  author_id INTEGER,
  FOREIGN key(author_id) REFERENCES users(id)
);

CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,
  FOREIGN key(question_id) REFERENCES questions(id),
   FOREIGN KEY(user_id) REFERENCES users(id)
 );

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  parent_id INTEGER,
  author_id INTEGER,
  body TEXT,
  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(parent_id) REFERENCES replies(id), 
  FOREIGN KEY(author_id) REFERENCES users(id)
 );

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  user_id INTEGER,
  likes TEXT, 
  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);
  
  
  INSERT INTO 
    USERS (fname, lname)
  VALUES
    ('Jaya', 'Dammalapati'),
    ('Safuh', 'Sarayji');
  

  INSERT INTO
    questions (title, body, author_id)
  VALUES
    ('Recursion', 'How to solve permutations?', 1),
    ('ORM', 'How to create a TABLE?', 2);
    
    
  INSERT INTO
    question_follows (user_id, question_id)
  VALUES
    (1, 2),
    (2, 1);
    
  INSERT INTO
    replies (question_id, author_id, body)
  VALUES
    (1, 1, 'have a base case first the break it into smaller problems');
  
    
  INSERT INTO
    replies (question_id, parent_id, author_id, body)
  VALUES
    (1, 1, 1, 'Inductive steps');
    
  INSERT INTO
    question_likes(question_id, user_id, likes )
  Values
    (2, 1, 'true');
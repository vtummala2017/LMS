# Whiteboard Simple

A small learning management system: courses, join codes, announcements, assignments,
file/text submissions, **auto-graded multiple-choice quizzes**, grading with feedback, gradebook, and an admin page.
Tech: Python + PostgreSQL. No Node, no Redis, no build step. Runs as one container.

## The easiest way: Render (no server skills needed, about 10 minutes)
1. Put this folder in a free GitHub repository (github.com > New > upload files).
2. Sign up at render.com > New > **Blueprint** > choose your repo > Apply.
   It creates the website and a PostgreSQL database and gives you an https:// address.
3. Open the address and **register first**. The first account becomes the admin.
4. In **Admin**, promote your teachers. Teachers create courses and share the join code;
   students sign up and join with the code.
Add your own domain later in Render > Settings > Custom Domains.

## Self-host instead (one cheap server)
Ubuntu server, 2 CPU / 4 GB RAM, domain pointing at it, then:  `bash install.sh`
(Installs Docker, makes passwords, starts everything, schedules daily backups.)

## Sizing for 10,000 users
10,000 *registered* users with normal use is comfortable on 2 CPU / 4 GB (or Render "standard")
with a 1 GB database. If 1,500+ people are online at the same moment (exam time), use
4 CPU / 8 GB and set WEB_CONCURRENCY=8. Load-test before launch.

## Know the limits
- Files are stored in the database (max 5 MB each); great for assignments, not for lecture videos
  (link to YouTube/Drive/Vimeo instead).
- Quizzes are multiple-choice only, one attempt each, and can't be edited after creation.
- No discussions, calendar, email notifications, or LTI. Those are the next things to add.
- Upgrading from the earlier version is automatic: new database columns are added on startup.
- Not Canvas-complete. This is a deliberately small, reliable core.

## Run locally to try it
`pip install -r requirements.txt` then `uvicorn app.main:app --reload` and open http://localhost:8000

# Feedback setup (Google Form)

1. Create a Google Form with these questions (all "Short answer" or "Paragraph"):
   Type, Message, Rating, Contact, App.
2. Form settings -> Responses: link to a Google Sheet; turn on "Get email notifications for new responses".
3. In the Form: three dots -> "Get pre-filled link". Type dummy words in each question, press "Get link", copy the link.
4. The pre-filled link contains entry.NUMBER values. Put them, and the Form address ending in /formResponse, into lib/core/feedback_config.dart.
5. The app sends the customer's message straight to the Form. No personal email or phone number is shown in the app.

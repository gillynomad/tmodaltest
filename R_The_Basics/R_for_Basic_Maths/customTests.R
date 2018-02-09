# Put custom tests in this file.

      # Uncommenting the following line of code will disable
      # auto-detection of new variables and thus prevent swirl from
      # executing every command twice, which can slow things down.

      # AUTO_DETECT_NEWVAR <- FALSE

      # However, this means that you should detect user-created
      # variables when appropriate. The answer test, creates_new_var()
      # can be used for for the purpose, but it also re-evaluates the
      # expression which the user entered, so care must be taken.

notify <- function() {
      e <- get("e", parent.frame())
      if(e$val == "No") return(TRUE)

      good <- FALSE
      while(!good) {
        # Get info
        name <- readline_clean("What is your name? ")
        address <- readline_clean("What is the email address you would like to receive the record of completion? ")

        # Repeat back to them
        message("\nDoes everything look good?\n")
        message("Your name: ", name, "\n", "Send to: ", address)

        yn <- select.list(c("Yes", "No"), graphics = FALSE)
        if(yn == "Yes") good <- TRUE
      }

      # Get course and lesson names
      course_name <- attr(e$les, "course_name")
      lesson_name <- attr(e$les, "lesson_name")

      subject <- paste(name, "just completed", course_name, "-", lesson_name)
      body = "Congratulations on completing this lesson. Please find attached a jobaid describing some of the important code used."

      attachmentPath <- "R_for_Basic_Maths/Arthimetic_and_Objects_JobAid.pdf"
      #key part for attachments, put the body and the mime_part in a list for msg
      attachmentObject <- mime_part(x=attachmentPath,name=attachmentName)
      bodyWithAttachment <- list(body,attachmentObject)

      sendmail(from=from,to=to,subject=subject,msg=bodyWithAttachment,control=mailControl)

      # Send email
      #swirl:::email(address, subject, bodyWithAttachment)

      hrule()
      message("I just tried to create a new email with the following info:\n")
      message("To: ", address)
      message("Subject: ", subject)
      message("Body: <empty>")

      message("\nIf it didn't work, you can send the same email manually.")
      hrule()

      # Return TRUE to satisfy swirl and return to course menu
      TRUE
    }

    readline_clean <- function(prompt = "") {
      wrapped <- strwrap(prompt, width = getOption("width") - 2)
      mes <- stringr::str_c("| ", wrapped, collapse = "\n")
      message(mes)
      readline()
    }

    hrule <- function() {
      message("\n", paste0(rep("#", getOption("width") - 2), collapse = ""), "\n")
    }

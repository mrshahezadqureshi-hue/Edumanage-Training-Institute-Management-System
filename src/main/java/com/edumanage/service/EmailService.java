package com.edumanage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${app.mail.from:${spring.mail.username}}")
    private String fromAddress;

    public void sendApprovalEmail(String toEmail, String fullName, String username, String rawPassword) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");

            helper.setFrom(fromAddress, "EduManage Portal");
            helper.setTo(toEmail);
            helper.setSubject("Welcome to EduManage - Your Account is Approved");

            String htmlContent = "<!DOCTYPE html>"
                + "<html><head><meta charset='UTF-8'>"
                + "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                + "<style>"
                + "body{font-family:Arial,sans-serif;background:#f4f7f6;margin:0;padding:24px;}"
                + ".container{max-width:600px;margin:auto;background:#fff;border-radius:12px;overflow:hidden;border:1px solid #e5e7eb;}"
                + ".header{background:#1e3c72;padding:28px 20px;text-align:center;color:#fff;}"
                + ".header h1{margin:0;font-size:22px;}"
                + ".content{padding:28px;color:#333;line-height:1.6;font-size:15px;}"
                + ".cred{background:#f8fafc;border-left:4px solid #2563eb;padding:16px;margin:20px 0;}"
                + ".row{margin:9px 0;} .label{font-weight:bold;display:inline-block;width:90px;}"
                + ".value{background:#e2e8f0;padding:4px 8px;border-radius:4px;font-family:monospace;font-weight:bold;}"
                + ".footer{background:#f1f5f9;padding:16px;text-align:center;color:#64748b;font-size:12px;}"
                + "</style></head><body>"
                + "<div class='container'>"
                + "<div class='header'><h1>Welcome to EduManage</h1></div>"
                + "<div class='content'>"
                + "<p>Dear <strong>" + fullName + "</strong>,</p>"
                + "<p>Your registration has been successfully <strong>approved</strong> by the administrator.</p>"
                + "<div class='cred'>"
                + "<div class='row'><span class='label'>Username:</span><span class='value'>" + username + "</span></div>"
                + "<div class='row'><span class='label'>Password:</span><span class='value'>" + rawPassword + "</span></div>"
                + "</div>"
                + "<p>You can now log in to the EduManage portal using these credentials.</p>"
                + "<p style='color:#dc2626;font-size:13px;'><em>Please change your temporary password after logging in.</em></p>"
                + "</div><div class='footer'>&copy; 2026 EduManage Training Management System</div>"
                + "</div></body></html>";

            helper.setText(htmlContent, true);
            mailSender.send(message);
            System.out.println("EduManage approval email sent successfully to: " + toEmail);
        } catch (MessagingException | java.io.UnsupportedEncodingException | MailException e) {
            throw new IllegalStateException(
                    "Gmail SMTP rejected the approval email. Check the Gmail App Password and SMTP settings. Details: " + e.getMessage(),
                    e
            );
        } catch (RuntimeException e) {
            throw new IllegalStateException(
                    "Gmail SMTP rejected the approval email. Details: " + e.getMessage(),
                    e
            );
        }
    }

}
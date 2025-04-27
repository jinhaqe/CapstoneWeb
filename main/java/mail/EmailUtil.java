package mail;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {
    public static void sendEmail(String recipientEmail, String subject, String content) throws MessagingException {
        // SMTP 서버 설정
        String host = "smtp.gmail.com";
        final String user = "manmanmanmando@gmail.com"; // 발신자 이메일
        final String password = "zyudosyihhknjrvz"; // 발신자 이메일 비밀번호 또는 앱 비밀번호

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // 인증 정보 생성
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        // 메일 작성
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(user));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject(subject);
        message.setText(content);

        // 메일 전송
        try {
            Transport.send(message);
            System.out.println("메일 전송 성공");
        } catch (MessagingException e) {
            System.err.println("메일 전송 실패: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
}
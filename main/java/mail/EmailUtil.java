package mail;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {
    public static void sendEmail(String recipientEmail, String subject, String content) throws MessagingException {
        // SMTP ���� ����
        String host = "smtp.gmail.com";
        final String user = "manmanmanmando@gmail.com"; // �߽��� �̸���
        final String password = "zyudosyihhknjrvz"; // �߽��� �̸��� ��й�ȣ �Ǵ� �� ��й�ȣ

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // ���� ���� ����
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        // ���� �ۼ�
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(user));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject(subject);
        message.setText(content);

        // ���� ����
        try {
            Transport.send(message);
            System.out.println("���� ���� ����");
        } catch (MessagingException e) {
            System.err.println("���� ���� ����: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
}
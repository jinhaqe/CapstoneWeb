package chat;

public class Chat {
	private int chatNum;
	private String chatID;
	private String userID;
	private String chatDate;
	private String chatContent;
	public int getChatNum() {
		return chatNum;
	}
	public void setChatNum(int chatNum) {
		this.chatNum = chatNum;
	}
	public String getChatID() {
		return chatID;
	}
	public void setChatID(String matchingID) {
		this.chatID = matchingID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getChatDate() {
		return chatDate;
	}
	public void setChatDate(String chatDate) {
		this.chatDate = chatDate;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	
	
}

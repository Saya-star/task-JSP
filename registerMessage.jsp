<%@ page contentType="text/html; charset=UTF-8"%>

<%
//セッションの有効期限設定
session.setMaxInactiveInterval(180);
String logout = (String) request.getParameter("logout");
String message = null;
if (logout != null && logout.equals("true")) {
	//セッションの破棄
	session.invalidate();
} else {
	//GETパラメータからメッセージを取り出す
	message = (String) request.getParameter("message");
	if (message != null) {
		//メッセージが送信されていたので、セッションに保存
		session.setAttribute("message", message);
	} else {
		// メッセージが送信されていなかったのでセッションからメッセージを取得
		message = (String) session.getAttribute("message");
	}
}
if (message == null)
	message = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registerMessage</title>
<style>
ul {
	list-style: none;
}
</style>
</head>
<body>
	<form method="GET" action="/jsp/registerMessage.jsp">
		<ul>
			<li><label for="message">メッセージ</label><input type="text"
				name="message" value="<%=message%>" /></li>
			<li><input type="submit" value="登録" /> <a
				href="/jsp/registerMessage.jsp?logout=true">ログアウト</a></li>
		</ul>
	</form>
</body>
</html>
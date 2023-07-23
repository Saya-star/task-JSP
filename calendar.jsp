<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ja_JP" />
<%!
private static Map eventMap = new HashMap();
static {
	eventMap.put("20230101","お正月");
	eventMap.put("20231225","クリスマス");
	eventMap.put("20231231","大晦日");
	eventMap.put("20230102","箱根駅伝・往路");
	eventMap.put("20230103","箱根駅伝・復路");
	eventMap.put("20230109","成人の日");
	eventMap.put("20230203","節分");
	eventMap.put("20230214","バレンタインデー");
	eventMap.put("20230303","ひな祭り");
	eventMap.put("20230314","ホワイトデー");
	eventMap.put("20230403","入社式");
	eventMap.put("20230505","こどもの日");
	eventMap.put("20230514","母の日");
	eventMap.put("20230618","父の日");
	eventMap.put("20230707","七夕");
	eventMap.put("20230730","土用の丑の日");
	eventMap.put("20230813","お盆");
	eventMap.put("20230814","お盆");
	eventMap.put("20230815","お盆");
	eventMap.put("20230816","お盆");
	eventMap.put("20230918","敬老の日");
	eventMap.put("20231031","ハロウィン");
	eventMap.put("20231111","ポッキーの日");
}
%>
<%
//リクエストのパラメーターから日付を取り出す処理
String year = (String)request.getParameter("year");
String month = (String)request.getParameter("month");
String day = (String)request.getParameter("day");

LocalDate localDate = null;
if(year == null || month == null || day == null){
	//日付が送信されていないので、現在時刻を元に日付の設定を行う
	//現在時刻を示すLocalDateのインスタンスを取得する処理を追加
	localDate = LocalDate.now();
	
	year = String.valueOf(localDate.getYear());
	month = String.valueOf(localDate.getMonthValue());
	day = String.valueOf(localDate.getDayOfMonth());
} else {
	//送信された日付を元に、LocalDateのインスタンスを生成する
	localDate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
}
String[] dates = { year, month, day };

//画面で利用するための日付、イベント情報を保存する処理
request.setAttribute("dates",dates);
request.setAttribute("date",Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
String event = (String)eventMap.get(year + month + day);
request.setAttribute("event",event);
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<style>
ul {
	list-style: none;
}
</style>
</head>
<body>
<!-- ここにformタグを追加 -->
<form method="POST" action="/jsp/calendar.jsp">
<ul>
<!-- ここに日付送信用のinputタグを追加 -->
<li>
	<input type="text" name="year" value="${param['year']}"/><label for="year">年</label>
	<input type="text" name="month" value="${param['month']}"/><label for="month">月</label>
	<input type="text" name="day" value="${param['day']}"/><label for="day">日</label>
</li>
<li><input type="submit" value="送信" /></li>
<!--  ここに日付と曜日、イベント名を追加 -->
<li><c:out value="${fn:join(dates,'/')}"/>(<fmt:formatDate value="${date}" pattern="E"/>)</li>
<li><c:out value="${event}"/></li>
</ul>
</form>
</body>
</html>
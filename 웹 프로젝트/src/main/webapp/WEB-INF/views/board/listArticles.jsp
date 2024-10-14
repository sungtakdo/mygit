<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
    request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <meta charset=UTF-8">
    <title>게시판 정보 출력창</title>
</head>
<body>
<table border="1" align="center" width="80%">
    <tr align="center" bgcolor="lightgreen">
        <td ><b>글번호</b></td>
        <td><b>제목</b></td>
        <td><b>내용</b></td>
        <td><b>작성일</b></td>
    </tr>
    <c:forEach var="article" items="${articlesList}" >
        <tr align="center">
            <td>${article.articleNO}</td>
            <td>${article.title}</td>
            <td>${article.content}</td>
            <td>${article.writeDate}</td>
        </tr>
    </c:forEach>
</table>
<a href="${contextPath}/board/boardForm.do"><h1
        style="text-align:center">새글작성</h1></a>
</body>
</html>
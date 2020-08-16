<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="js/bootstrap.js"></script>
<title>JSP Board</title>
</head>
<body>
	<%
		String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP Board</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">main</a></li>
				<li class="active"><a href="board.jsp">board</a></li>
			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class='dropdown-toggle'
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">Menu<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">Sign in</a>
						<li><a href="join.jsp">Sign up</a>
					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class='dropdown-toggle'
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">Mypage<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">Logout</a>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">number</th>
						<th style="background-color: #eeeeee; text-align: center;">title</th>
						<th style="background-color: #eeeeee; text-align: center;">author</th>
						<th style="background-color: #eeeeee; text-align: center;">date</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getBbsID()%></td>
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>">
								<%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")%></a></td>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getBbsDate()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
			<a href="board.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arraw-left">previous</a>
			<%
				}
			if (bbsDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="board.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arraw-left">next</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">Writing</a>
		</div>
	</div>
</body>
</html>
<html>
<head>
<title>Login Page</title>
<meta name="layout" content="main">
</head>

<body>
	<div class="body">
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<p>malloc login</p>
		<form action="handleLogin">
			<span class="nameClear"><label for="login">Sign in</label> </span>
			<g:select name="code" from="${malloc.User.list()}" optionKey="code"></g:select>
			<br />
			<div class="buttons">
				<span class="button"><g:actionSubmit value="Login" action="handleLogin"/> </span>
			</div>
		</form>
	</div>
</body>
</html>
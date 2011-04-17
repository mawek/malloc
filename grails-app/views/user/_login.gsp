<div class="body">
	<g:if test="${flash.login?.message}">
		<div class="message">
			${flash.login?.message}
		</div>
	</g:if>
	<g:form action="handleLogin" controller="user" method="post">
		<g:select name="code" from="${malloc.User.list()}" optionKey="code"></g:select>
		<span class="button"><g:actionSubmit value="${message(code:'login')}" action="handleLogin" /> </span>
	</g:form>
</div>


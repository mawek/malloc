<div class="body">
	<g:if test="${flash.login?.message}">
		<div class="message">
			${flash.login?.message}
		</div>
	</g:if>
	<g:form action="login" controller="login" method="post">
		<g:select name="code" from="${malloc.User.list()}" optionKey="code"></g:select>
		<span class="button"><g:actionSubmit value="${message(code:'login')}" action="login" /> </span>
	</g:form>
</div>


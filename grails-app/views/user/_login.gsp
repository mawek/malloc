<div class="body">
	<g:if test="${flash.message}">
		<div class="message">
			${flash.message}
		</div>
	</g:if>
	<g:form action="handleLogin" controller="user">
		<g:select name="code" from="${malloc.User.list()}" optionKey="code"></g:select>
		<span class="button"><g:actionSubmit value="${message(code:'login')}" action="handleLogin" /> </span>
	</g:form>
</div>


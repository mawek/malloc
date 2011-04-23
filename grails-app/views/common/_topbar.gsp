<div id="login_menu">
	<nobr>
		<g:if test="${session.user}">
			<b> ${session.user?.code}&nbsp;-&nbsp;${session.user?.name}&nbsp;${session.user?.surname}&nbsp;|&nbsp;<g:link controller="login" action="logout"><g:message code="logout"/></g:link>
			</b>
		</g:if>
		<g:else>
			<g:render template="/login/login" />
		</g:else>
	</nobr>
</div>

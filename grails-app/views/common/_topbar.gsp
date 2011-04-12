<div id="menu">
	<nobr>
		<g:if test="${session.user}">
			<b> ${session.user?.code}&nbsp;-&nbsp;${session.user?.name}&nbsp;${session.user?.surname}&nbsp;|&nbsp;<g:link controller="user" action="logout">Logout</g:link>
			</b>
		</g:if>
		<g:else>
			<g:render template="/user/login" />
		</g:else>
	</nobr>
</div>

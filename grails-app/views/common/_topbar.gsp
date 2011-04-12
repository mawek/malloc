<div id="menu">
	<nobr>
		<g:if test="${session.user}">
			<b> ${session.user?.code}-${session.user?.name}&nbsp;${session.user?.surname}|<g:link controller="user" action="logout">Logout</g:link> </b>
		</g:if>
		<g:else>
			<g:link controller="user" action="login">Login</g:link>
		</g:else>
	</nobr>
</div>
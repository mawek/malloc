<%@ page import="malloc.Allocation"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title><g:message code="allocation.list.label" />
</title>
</head>
<body>
	<div class="nav">
		<span class="menuButton"><g:link class="create" action="create">
				<g:message code="allocation.new.label" />
			</g:link> </span>
	</div>
	
	<!-- alokacie na mna -->
	<div class="body">
		<h1>
			<g:message code="allocation.list.my.allocations.label" default="My allocations"/>
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<div class="list">
			<table>
				<thead>
					<tr>

						<g:sortableColumn property="name" title="${message(code: 'allocation.name.label', default: 'Name')}" />

						<g:sortableColumn property="type" title="${message(code: 'allocation.type.label', default: 'Type')}" />

						<g:sortableColumn property="status" title="${message(code: 'allocation.status.label', default: 'Status')}" />

						<th><g:message code="allocation.requester.label" default="Requester" />
						</th>

						<th><g:message code="allocation.worker.label" default="Worker" />
						</th>

						<th><g:message code="allocation.approver.label" default="Approver" />
						</th>

						<g:sortableColumn property="when" title="${message(code: 'allocation.when.label', default: 'When')}" />

					</tr>
				</thead>
				<tbody>
					<g:each in="${myAllocations}" status="i" var="allocation">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

							<td><g:link action="show" id="${allocation.id}">
									${fieldValue(bean: allocation, field: "name")}
								</g:link></td>

							<td>
								${message(code: 'allocation.type.'+allocation?.type?.encodeAsHTML(), default: allocation?.type?.encodeAsHTML())}
							</td>

							<td>
								${message(code: 'allocation.status.'+allocation?.status?.encodeAsHTML(), default: allocation?.status?.encodeAsHTML())}
							</td>

							<td><g:link action="show" controller="user" id="${allocation.requester?.id}">
									${allocation.requester?.code}
								</g:link></td>

							<td><g:link action="show" controller="user" id="${allocation.worker?.id}">
									${allocation.worker?.code}
								</g:link></td>

							<td><g:link action="show" controller="user" id="${allocation.approver?.id}">
									${allocation.approver?.code}
								</g:link></td>
							<td><g:formatDate date="${allocation.when?.toDate()}" format="dd.MM.yyyy" /></td>

						</tr>
					</g:each>
				</tbody>
			</table>
		</div>		
	</div>
	
	
	<br />
	
	<!-- moje schvalovanie alokacii -->
	<div class="body">
		<h1>
			<g:message code="allocation.list.my.approvals.label" default="Allocations waiting for my aproval"/>
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<div class="list">
			<table>
				<thead>
					<tr>

						<g:sortableColumn property="name" title="${message(code: 'allocation.name.label', default: 'Name')}" />

						<g:sortableColumn property="type" title="${message(code: 'allocation.type.label', default: 'Type')}" />

						<g:sortableColumn property="status" title="${message(code: 'allocation.status.label', default: 'Status')}" />

						<th><g:message code="allocation.requester.label" default="Requester" />
						</th>

						<th><g:message code="allocation.worker.label" default="Worker" />
						</th>

						<th><g:message code="allocation.approver.label" default="Approver" />
						</th>

						<g:sortableColumn property="when" title="${message(code: 'allocation.when.label', default: 'When')}" />

					</tr>
				</thead>
				<tbody>
					<g:each in="${myApproves}" status="i" var="allocation">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

							<td><g:link action="show" id="${allocation.id}">
									${fieldValue(bean: allocation, field: "name")}
								</g:link></td>

							<td>
								${message(code: 'allocation.type.'+allocation?.type?.encodeAsHTML(), default: allocation?.type?.encodeAsHTML())}
							</td>

							<td>
								${message(code: 'allocation.status.'+allocation?.status?.encodeAsHTML(), default: allocation?.status?.encodeAsHTML())}
							</td>

							<td><g:link action="show" controller="user" id="${allocation.requester?.id}">
									${allocation.requester?.code}
								</g:link></td>

							<td><g:link action="show" controller="user" id="${allocation.worker?.id}">
									${allocation.worker?.code}
								</g:link></td>

							<td><g:link action="show" controller="user" id="${allocation.approver?.id}">
									${allocation.approver?.code}
								</g:link></td>
							<td><g:formatDate date="${allocation.when?.toDate()}" format="dd.MM.yyyy" /></td>

						</tr>
					</g:each>
				</tbody>
			</table>
		</div>		
	</div>
	
	<!-- ziadost o alokacie -->
	<div class="body">
		<h1>
			<g:message code="allocation.list.my.requests.label" default="My allocation requests"/>
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<div class="list">
			<table>
				<thead>
					<tr>

						<g:sortableColumn property="name" title="${message(code: 'allocation.name.label', default: 'Name')}" />

						<g:sortableColumn property="type" title="${message(code: 'allocation.type.label', default: 'Type')}" />

						<g:sortableColumn property="status" title="${message(code: 'allocation.status.label', default: 'Status')}" />

						<th><g:message code="allocation.requester.label" default="Requester" />
						</th>

						<th><g:message code="allocation.worker.label" default="Worker" />
						</th>

						<th><g:message code="allocation.approver.label" default="Approver" />
						</th>

						<g:sortableColumn property="when" title="${message(code: 'allocation.when.label', default: 'When')}" />

					</tr>
				</thead>
				<tbody>
					<g:each in="${myRequests}" status="i" var="allocation">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

							<td><g:link action="show" id="${allocation.id}">
									${fieldValue(bean: allocation, field: "name")}
								</g:link></td>

							<td>
								${message(code: 'allocation.type.'+allocation?.type?.encodeAsHTML(), default: allocation?.type?.encodeAsHTML())}
							</td>

							<td>
								${message(code: 'allocation.status.'+allocation?.status?.encodeAsHTML(), default: allocation?.status?.encodeAsHTML())}
							</td>

							<td><g:link action="show" controller="user" id="${allocation.requester?.id}">
									${allocation.requester?.code}
								</g:link></td>

							<td><g:link action="show" controller="user" id="${allocation.worker?.id}">
									${allocation.worker?.code}
								</g:link></td>

							<td><g:link action="show" controller="user" id="${allocation.approver?.id}">
									${allocation.approver?.code}
								</g:link></td>
							<td><g:formatDate date="${allocation.when?.toDate()}" format="dd.MM.yyyy" /></td>

						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>	
	
</body>
</html>
<html>
	<head>
		<title>úprava alokace</title>
		
		<STYLE type="text/css">
   			table {
   				padding:5px;
   				border: 1px solid;
   			}
   			td,th {
				font: 11px verdana, arial, helvetica, sans-serif;
				line-height: 12px;
				padding: 5px 6px;
				text-align: left;
				vertical-align: middle;
				white-space: nowrap;
			}
			th {
				background: #ddd;	
			}
 		</STYLE>
	</head>

	<body>
		<p>
			Došlo k úpravě alokace.
		</p>

		<table>
			<tr>
				<th></th>
				<th><g:message code="allocation.mail.old"/></th>
				<th><g:message code="allocation.mail.new"/></th>
			</tr>

			<g:if test="${oldAllocation.name != newAllocation.name}">
				<tr>
					<th><g:message code="allocation.name.label" default="Name" />:</th>
					<td>
						${oldAllocation.name}
					</td>
					<td>
						${newAllocation.name}
					</td>
				</tr>
			</g:if>

			<g:if test="${oldAllocation.description != newAllocation.description}">
				<tr>
					<th><g:message code="allocation.description.label" default="Description" />:</th>
					<td>
						${oldAllocation.description}
					</td>
					<td>
						${newAllocation.description}
					</td>
				</tr>
			</g:if>

			<g:if test="${oldAllocation.status != newAllocation.status}">
				<tr>
					<th><g:message code="allocation.status.label" default="Status" />:</th>
					<td>
						${message(code: 'allocation.status.'+oldAllocation.status?.encodeAsHTML(), default: oldAllocation?.status?.encodeAsHTML())}
					</td>
					<td>
						${message(code: 'allocation.status.'+newAllocation.status?.encodeAsHTML(), default: newAllocation?.status?.encodeAsHTML())}
					</td>
				</tr>
			</g:if>

			<g:if test="${oldAllocation.type != newAllocation.type}">
				<tr>
					<th><g:message code="allocation.type.label" default="Type" />:</th>
					<td>
						${message(code: 'allocation.type.'+oldAllocation.type?.encodeAsHTML(), default: oldAllocation?.type?.encodeAsHTML())}
					</td>
					<td>
						${message(code: 'allocation.type.'+newAllocation.type?.encodeAsHTML(), default: newAllocation?.type?.encodeAsHTML())}
					</td>
				</tr>
			</g:if>

			<g:if test="${oldAllocation.startDate != newAllocation.startDate}">
				<tr>
					<th><g:message code="allocation.startDate.label" default="Start date" />:</th>
					<td>
						<g:formatDate date="${oldAllocation.startDate.toDate()}" format="dd.MM.yyyy" />
					</td>
					<td>
						<g:formatDate date="${newAllocation.startDate.toDate()}" format="dd.MM.yyyy" />
					</td>
				</tr>
			</g:if>

			<g:if test="${oldAllocation.endDate != newAllocation.endDate}">
				<tr>
					<th><g:message code="allocation.endDate.label" default="End date" />:</th>
					<td>
						<g:formatDate date="${oldAllocation.endDate.toDate()}" format="dd.MM.yyyy" />
					</td>
					<td>
						<g:formatDate date="${newAllocation.endDate.toDate()}" format="dd.MM.yyyy" />
					</td>
				</tr>
			</g:if>

			<g:if test="${oldAllocation.worker != newAllocation.worker}">
				<tr>
					<th><g:message code="allocation.worker.label" default="Worker" />:</th>
					<td>
						<g:link absolute="true" action="show" controller="user" params="${[id:oldAllocation.worker?.id]}">${oldAllocation.worker}</g:link>
					</td>
					<td>
						<g:link absolute="true" action="show" controller="user" params="${[id:newAllocation.worker?.id]}">${newAllocation.worker}</g:link>
					</td>
				</tr>
			</g:if>

			<g:if test="${oldAllocation.approver != newAllocation.approver}">
				<tr>
					<th><g:message code="allocation.approver.label" default="Approver" />:</th>
					<td>
						<g:link absolute="true" action="show" controller="user" params="${[id:oldAllocation.approver?.id]}">${oldAllocation.approver}</g:link>
					</td>
					<td>
						<g:link absolute="true" action="show" controller="user" params="${[id:newAllocation.approver?.id]}">${newAllocation.approver}</g:link>
					</td>
				</tr>
			</g:if>

			<g:if test="${oldAllocation.hours != newAllocation.hours}">
				<tr>
					<th><g:message code="allocation.hours.label" default="Hours" />:</th>
					<td>
						${oldAllocation.hours}
					</td>
					<td>
						${newAllocation.hours}
					</td>
				</tr>
			</g:if>

			<g:if test="${oldAllocation.link != newAllocation.link}">
				<tr>
					<th><g:message code="allocation.link.label" default="Link" />:</th>
					<td>
						${oldAllocation.link}
					</td>
					<td>
						${newAllocation.link}
					</td>
				</tr>
			</g:if>

		</table>

		<p>			
			<g:link absolute="true" action="show" controller="allocation" params="${[id:newAllocation.id]}"><g:message code="allocation.link"/></g:link>
		</p>
	</body>
</html>
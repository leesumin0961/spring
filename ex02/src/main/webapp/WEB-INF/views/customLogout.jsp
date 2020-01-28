<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="./includes/header.jsp"%>

<div class="container-fluid">

	<div class="card shadow mb-4"
		style="width: 50% !important; margin: auto !important">

		<div class="card-header py-3">
			<h4 class="m-0 font-weight-bold text-primary">Logout</h4>
		</div>

		<div class="card-body">

				<form action="/customLogout" method='post'>
					<div style="padding-bottom: 30px">로그아웃 하시겟습니까?</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />

					<button class="btn btn-outline-secondary form-control">로그아웃</button>
				</form>
		</div>

		<div class="card-footer">
		</div>
	</div>
</div>

<%@ include file="./includes/footer.jsp"%>



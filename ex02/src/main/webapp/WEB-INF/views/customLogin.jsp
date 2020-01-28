<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="./includes/header.jsp"%>

<div class="container-fluid">
	
	<div class="card shadow mb-4" style="width:50% !important; margin:auto !important">
	
		<div class="card-header py-3">
              <h4 class="m-0 font-weight-bold text-primary">Login</h4>
        </div>
        
		<div class="card-body">
		<form method="post" action="/login">
			<div class="form-group">
				<input class="form-control" placeholder="id" type="text" name="username">
			</div>
			<div class="form-group">
				<input class="form-control" placeholder="pw" type="password" name="password">
			</div>
			<div class="checkbox">
				<input type="checkbox" name="remember-me">자동로그인
			</div>	
			<div class="form-group">
				<input class="form-control" type="submit" value="로그인">		
			</div>	
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
		</div>
		
		<div class="card-footer">
		<c:out value="${error}"></c:out>
		<%-- <c:out value="${logout}"></c:out> --%>
		</div>
		
	</div>
</div>

<%@ include file="./includes/footer.jsp"%>

<c:if test="${param.logout != null}">
      <script>
      $(document).ready(function(){
    	  if(history.state){
    		  return;
    	  }
      	alert("로그아웃하였습니다.");
      	history.replaceState({},null,null);
      	
     });
      </script>
</c:if>  

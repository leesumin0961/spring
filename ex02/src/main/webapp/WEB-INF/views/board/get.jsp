<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../includes/header.jsp"%>

<style>
.uploadResult {
	width: 100%;
	/* background-color: white; */
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: dimgray;
}

.bigPictureWrapper {
	cursor: pointer;
	position: fixed !important;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0% !important;
	left: 0% !important;
	width: 100%;
	height: 100%;
	z-index: 100;
	background: rgba(0, 0, 0, 0.8) !important;
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>

<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>




<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">Board</h1>


	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h4 class="m-0 font-weight-bold text-primary">Read</h4>


		</div>
		<div class="card-body">
			<div class="form-group">
				<label>Bno</label> <input class="form-control" value="${board.bno}"
					name='bno' readonly="readonly">
			</div>
			<div class="form-group">
				<label>Title</label> <input class="form-control"
					value="${board.title}" name="title" readonly>
			</div>
			<div class="form-group">
				<label>Content</label>
				<textarea class="form-control" rows="10" name="content" readonly>${board.content}</textarea>
			</div>
			<div class="form-group">
				<label>Writer</label> <input class="form-control"
					value="${board.writer}" name="writer" readonly>
			</div>


			<!-- 첨부파일추가영역-------------------------------------------------------------------- -->


			<div class="row">
				<div class="col-lg-12">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h5 class="text-primary">File Attach</h5>
						</div>
						<!-- /.card-heading -->
						<div class="card-body">

							<div class='uploadResult'>
								<ul>
								</ul>
							</div>
							<!--  end card-body -->
						</div>
						<!--  end card-body -->
					</div>
					<!-- end card -->
				</div>
				<!-- /.row -->
			</div>



			<!-- 첨부파일추가영역  끝-------------------------------------------------------------------- -->

		</div>
	</div>

	<%-- 	<a data-oper='modify' class="btn btn-outline-secondary btn-sm"
	href="/board/modify?bno=<c:out value="${board.bno}"/>">Modify</a>
	 <a data-oper='list' class="btn btn-outline-secondary btn-sm" href="/board/list">List</a>
	  --%>

	<form id='operForm' action="/boad/modify" method="get">

		<%-- <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'> --%>

		<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'> 
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'> 
		<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'> 
		<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
		<input type='hidden' name='writer' value='<c:out value="${board.writer}"/>'>
		
		<sec:authentication property="principal" var="pinfo" />
		<sec:authorize access="isAuthenticated()">
		<c:if test="${pinfo.username eq board.writer}">
		<button data-oper='modify' class="btn btn-outline-secondary  btn-sm">Modify</button>
		</c:if>
		</sec:authorize>
		<button data-oper='list' class="btn btn-outline-secondary  btn-sm">List</button>

	</form>

</div>
<!-- /.container-fluid -->





<!-- 댓글 ---------------------------------------------------------------------------------------->

&nbsp;
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<i class="fa fa-comments fa-fw"></i> Reply
			<sec:authorize access="isAuthenticated()">	
		<button id='addReplyBtn'
			class='btn btn-outline-secondary btn-sm float-right'>New
			Reply</button>
			</sec:authorize>


	</div>
	<div class="card-body">
		<ul class="chat list-group">

		</ul>
	</div>
	<div class="card-footer"></div>
</div>


<!-- 댓글 ---------------------------------------------------------------------------------------->


<!-- 댓글 Modal시작---------------------------------------------------------------------------------------->


<!-- The Modal -->
<div class="modal" id="myModal">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">REPLY MODAL</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name='reply'
						value='New Reply!!!!'>
				</div>

				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name='replyer'
						value='replyer' readonly="readonly">
				</div>

				<div class="form-group">
					<label>Reply Date</label> <input class="form-control"
						name='replyDate' value='2018-01-01 13:13'>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">

				<button id='modalModBtn' type="button" class="btn btn-outline-secondary">Modify</button>
				<button id='modalRemoveBtn' type="button"
					class="btn btn-outline-secondary">Remove</button>
				<button id='modalRegisterBtn' type="button"
					class="btn btn-outline-secondary">Register</button>
				<button id='modalCloseBtn' type="button"
					class="btn btn-outline-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>



<!-- 댓글 Modal끝---------------------------------------------------------------------------------------->

<%@ include file="../includes/footer.jsp"%>


<script src="/resources/js/reply.js"></script>


<script>
		$(document).ready(function() {

					var bnoValue = '<c:out value="${board.bno}"/>'; //부모글번호
					var replyUL = $(".chat");//댓글목록ul

					showList(1); //댓글목록.1페이지

					
					
			//댓글목록
				function showList(page){
	
				  console.log("show list " + page);
			    
			    replyService.getList({bno:bnoValue,page: page|| 1 }, function(replyCnt, list) {
			      
			    console.log("replyCnt: "+ replyCnt );
			    console.log("list: " + list);
			    console.log(list);
			    
			    if(page == -1){
			      pageNum = Math.ceil(replyCnt/10.0);
			      showList(pageNum);
			      return;
			    }
			      
			     var str="";
			     
			     if(list == null || list.length == 0){
			       return;
			     }
			     
			     for (var i = 0, len = list.length || 0; i < len; i++) {
			       str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
			       str +="  <div><div class='header'><strong class='primary-font'>["
			    	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
			       str +="    <small class='pull-right text-muted'>"
			           +replyService.displayTime(list[i].replyDate)+"</small></div>";
			       str +="    <p>"+list[i].reply+"</p></div></li>";
			     }
			     
			     replyUL.html(str);
					showReplyPage(replyCnt);
					
				});//end function

			}//end showList

			
		 
		    //댓글 페이징처리
		    
		    var pageNum = 1;
		    var replyPageFooter = $(".card-footer");
		    
		    function showReplyPage(replyCnt){
		      
		      var endNum = Math.ceil(pageNum / 10.0) * 10;  
		      var startNum = endNum - 9; 
		      
		      var prev = startNum != 1;
		      var next = false;
		      
		      if(endNum * 10 >= replyCnt){
		        endNum = Math.ceil(replyCnt/10.0);
		      }
		      
		      if(endNum * 10 < replyCnt){
		        next = true;
		      }
		      
		      var str = "<ul class='pagination float-right'>";
		      
		      if(prev){
		        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
		      }
		      
		      for(var i = startNum ; i <= endNum; i++){
		        
		        var active = pageNum == i? "active":"";
		        
		        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		      }
		      
		      if(next){
		        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
		      }
		      
		      str += "</ul></div>";
		      
		      console.log(str);
		      
		      replyPageFooter.html(str);
		      
		    }
		    
		    //댓글페이지번호를 눌렀을때 넘어가는 이벤트처리
		    replyPageFooter.on("click","li a",function(e){
		    	e.preventDefault();
		    	console.log("page click");
		    	
		    	
		    	var targetPageNum =$(this).attr("href");
		    	
		    	console.log("targetPageNum :" +targetPageNum);
		    	
		    	pageNum = targetPageNum;
		    	showList(pageNum);
		    });
		    
		    
		    
		    
		    

			var modal = $(".modal");
			var modalInputReply = modal.find("input[name='reply']"); //댓글내용
			var modalInputReplyer = modal
					.find("input[name='replyer']"); //작성자
			var modalInputReplyDate = modal
					.find("input[name='replyDate']"); //작성일

			var modalModBtn = $("#modalModBtn"); //수정버튼
			var modalRemoveBtn = $("#modalRemoveBtn"); //삭제버튼
			var modalRegisterBtn = $("#modalRegisterBtn"); //등록버튼

			//로그인한 id를 replyer로 설정
			var replyer = null;
			
			<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username"/>';
			</sec:authorize>
			
			var csrfHeaderName= "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			
			
			$("#modalCloseBtn").on("click", function(e) {

				modal.modal('hide');
			});
			
			 //new reply버튼 클릭시 모달창 띄우기
			$("#addReplyBtn").on("click", function(e) {

				modal.find("input").val(""); //입력항목초기화
				modal.find("input[name='replyer']").val(replyer);
				modalInputReplyDate.closest("div").hide(); //날짜안보이게
				modal.find("button[id !='modalCloseBtn']").hide(); //닫기버튼만보이게

				modalRegisterBtn.show(); //Register버튼 보이게

				$("#myModal").modal("show"); //모달창보이게

			});

			 //ajaxSend시 토큰값 전달---------------------------------------------------------------
		 
			    $(document).ajaxSend(function(e, xhr, options) { 
			        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
			      }); 
			 //ajaxSend시 토큰값 전달---------------------------------------------------------------
			 
			 
			//Register버튼 클릭시 댓글등록
			modalRegisterBtn.on("click", function(e) {

				var reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno : bnoValue
				};
				//댓글등록요청
				replyService.add(reply, function(result) {

					alert(result);//결과 message출력

					modal.find("input").val("");	//결과초기화
					modal.modal("hide");
					showList(1);

				});
			});

			//댓글상세보기 이벤트 처리
		   $(".chat").on("click", "li", function(e){
   
		      var rno = $(this).data("rno");
		      
		      replyService.get(rno, function(reply){
		      
		        modalInputReply.val(reply.reply);
		        modalInputReplyer.val(reply.replyer);
		        modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
		        .attr("readonly","readonly");
		        modal.data("rno", reply.rno);
		        
		        modal.find("button[id !='modalCloseBtn']").hide();
		        modalModBtn.show();
		        modalRemoveBtn.show();
		        
		        $("#myModal").modal("show");
		            
		      });
		    });

			//댓글수정
			modalModBtn.on("click", function(e) {

				var originalReplyer = modalInputReplyer.val();
				
				var reply = {
					rno : modal.data("rno"),
					reply : modalInputReply.val(),
					replyer : originalReplyer
				};
				
				if(!replyer){
			   		  alert("로그인후 수정이 가능합니다.");
			   		  modal.modal("hide");
			   		  return;
			   	  }
			   	  console.log("Original Replyer: " + originalReplyer);
			   	  
			   	  if(replyer  != originalReplyer){
			   		  
			   		  alert("자신이 작성한 댓글만 수정이 가능합니다.");
			   		  modal.modal("hide");
			   		  return;
			   	  }
				replyService.update(reply, function(result) {

					alert(result);
					$("#myModal").modal("hide");
					showList(pageNum);

				});

			});

			//댓글삭제

			modalRemoveBtn.on("click", function (e){
			   	  
			   	  var rno = modal.data("rno");

			   	  console.log("RNO: " + rno);
			   	  console.log("REPLYER: " + replyer);
			   	  
			   	  if(!replyer){
			   		  alert("로그인후 삭제가 가능합니다.");
			   		  modal.modal("hide");
			   		  return;
			   	  }
			   	  var originalReplyer = modalInputReplyer.val();
			   	  
			   	  console.log("Original Replyer: " + originalReplyer);
			   	  
			   	  if(replyer  != originalReplyer){
			   		  
			   		  alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			   		  modal.modal("hide");
			   		  return;
			   		  
			   	  }
			   	  replyService.remove(rno, originalReplyer, function(result){
			   	        
			   	      alert(result);
			   	      modal.modal("hide");
			   	      showList(pageNum);
			   	      
			   	  });
			   	  
			   	});

		});
</script>




<script>
$(document).ready(function() {

	var operForm = $("#operForm");
	$("button[data-oper='modify']").on("click", function(e) {

		operForm.attr("action", "/board/modify").submit();

	});

	$("button[data-oper='list']").on("click", function(e) {

		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list")
		operForm.submit();

	});
});
</script>



<script>




	$(document).ready(function() {
		
		//익명함수를 정의함과 동시에 호출
		(function() {
			var bno = '<c:out value="${board.bno}"/>';
			 $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
			       console.log(arr);
			       var str = "";
			       $(arr).each(function(i, attach){
			       
			         //image type
			         if(attach.fileType){
			           var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
			           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
			           str += "<img src='/display?fileName="+fileCallPath+"'>";
			           str += "</div>";
			           str +"</li>";
			         }else{
			           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
			           str += "<span> "+ attach.fileName+"</span><br/>";
			           str += "<img src='/resources/img/attach.png'></a>";
			           str += "</div>";
			           str +"</li>";
			         }
			       });
			       $(".uploadResult ul").html(str);
			     });//end getjson
		})();//end function
		

		
		  $(".uploadResult").on("click","li", function(e){
		      
			    console.log("view image");
			    var liObj = $(this);
			    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
			   //이미지이면 창띄우기
			    if(liObj.data("type")){
			      showImage(path.replace(new RegExp(/\\/g),"/"));
			    }else {
			      //파일일경우 download 
			      self.location ="/download?fileName="+path
			    }
			  });
		
		
		
		  function showImage(fileCallPath){
			    
			    //alert(fileCallPath);
			    $("#bigPictureWrap").css({"display":"block","background":"rgba(0,0,0,0.8)"});
			    $(".bigPictureWrapper").css("display","flex").show();

			    $(".bigPicture")
			    .html("<img src='/display?fileName="+fileCallPath+"' >")
			    .animate({width:'100%', height: '100%'}, 1000);
			    
			  }

			  $(".bigPictureWrapper").on("click", function(e){
			    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
			    setTimeout(function(){
			      $('.bigPictureWrapper').hide();
			    }, 1000);
			  });
		});
		
		
		
	
	
	
</script>

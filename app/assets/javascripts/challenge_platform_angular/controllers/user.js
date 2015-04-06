app.controller('UserCtrl', function($scope, $animate) {

  // function to submit the form after all validation has occurred            
  // $scope.createUser = function($event){
  //   // standard check for every user
  //   // $scope.fname_invalid = $scope.fname == null || $scope.fname == "";
  //   // $scope.lname_invalid = $scope.lname == null || $scope.lname == "";
  //   // $scope.email_invalid = $scope.email == null || $scope.email == "";
  //   // $scope.password_invalid = $scope.password == null || $scope.password == "";
  //   // $scope.role_invalid = ($scope.role == null || $scope.role == "") ? true : false;
    
  //   // resetting all role variables
  //   // $scope.title_invalid = false;
  //   // $scope.organization_invalid = false;
  //   // $scope.state_invalid = false;
  //   // $scope.district_invalid = false;
  //   // $scope.school_invalid = false;
  //   // $scope.extra_invalid = false;

  //   // role based validation
  //   // if (!$scope.role_invalid) {
  //   //   $scope.title_invalid = ($scope.title == null || $scope.title == '' && $scope.role != 'Pre-Service Teacher') ? true : false;

  //   //   if ($scope.role == 'Other' || $scope.role == 'Pre-Service Teacher' || $scope.other_lea || $scope.other_school) {
  //   //     $scope.organization_invalid = ($scope.organization == null || $scope.organization == '') ? true : false;
  //   //   } else if ($scope.role == 'SEA Staff') {
  //   //     // $scope.state_invalid = ($scope.user_state_ids == null || $scope.user_state_ids == '') ? true : false;
  //   //   } else if ($scope.role == 'LEA Staff') {
  //   //     // $scope.district_invalid = ($scope.user_district_ids == null || $scope.user_district_ids == '') ? true : false;
  //   //   } else {
  //   //     // $scope.school_invalid = ($scope.user_school_ids == null || $scope.user_school_ids == '') ? true : false;
  //   //   }

  //   //   $scope.extra_invalid =  $scope.title_invalid || 
  //   //                           $scope.organization_invalid || 
  //   //                           $scope.state_invalid || 
  //   //                           $scope.district_invalid || 
  //   //                           $scope.school_invalid;
  //   // }

  //   // determine whether form inputs are valid
  //   $scope.form_invalid = $scope.fname_invalid || 
  //                         $scope.lname_invalid || 
  //                         $scope.email_invalid || 
  //                         $scope.password_invalid || 
  //                         $scope.role_invalid || 
  //                         $scope.extra_invalid;

  //   // if not don't submit form
  //   if ($scope.form_invalid) {
  //     $scope.submitted = true;
  //     $animate.addClass($('#newUserForm'), 'shake').then(function(){$('#newUserForm').removeClass('shake');} );
  //     $event.preventDefault();
  //   }
  // }

  // function to submit the form after all validation has occurred
  // $scope.updateUser = function($event){
  //   // standard check for every user
  //   $scope.fname_invalid = $scope.fname == null || $scope.fname == "";
  //   $scope.lname_invalid = $scope.lname == null || $scope.lname == "";
  //   $scope.email_invalid = $scope.email == null || $scope.email == "";
  //   $scope.role_invalid = ($scope.role == null || $scope.role == "") ? true : false;
    
  //   // resetting all role variables
  //   // $scope.title_invalid = false;
  //   // $scope.organization_invalid = false;
  //   // $scope.state_invalid = false;
  //   // $scope.district_invalid = false;
  //   // $scope.school_invalid = false;
  //   // $scope.extra_invalid = false;

  //   // // role based validation
  //   // if (!$scope.role_invalid) {
  //   //   $scope.title_invalid = ($scope.title == null || $scope.title == '' && $scope.role != 'Pre-Service Teacher') ? true : false;

  //   //   if ($scope.role == 'Other' || $scope.role == 'Pre-Service Teacher' || $scope.other_lea || $scope.other_school) {
  //   //     $scope.organization_invalid = ($scope.organization == null || $scope.organization == '') ? true : false;
  //   //   } else if ($scope.role == 'SEA Staff') {
  //   //     // $scope.state_invalid = ($scope.user_state_ids == null || $scope.user_state_ids == '') ? true : false;
  //   //   } else if ($scope.role == 'LEA Staff') {
  //   //     // $scope.district_invalid = ($scope.user_district_ids == null || $scope.user_district_ids == '') ? true : false;
  //   //   } else {
  //   //     // $scope.school_invalid = ($scope.user_school_ids == null || $scope.user_school_ids == '') ? true : false;
  //   //   }

  //   //   $scope.extra_invalid =  $scope.title_invalid || 
  //   //                           $scope.organization_invalid || 
  //   //                           $scope.state_invalid || 
  //   //                           $scope.district_invalid || 
  //   //                           $scope.school_invalid;
  //   // }

  //   // determine whether form inputs are valid
  //   $scope.form_invalid = $scope.fname_invalid || 
  //                         $scope.lname_invalid || 
  //                         $scope.email_invalid || 
  //                         $scope.role_invalid || 
  //                         $scope.extra_invalid;

  //   // if not don't submit form
  //   if ($scope.form_invalid) {
  //     $scope.submitted = true;
  //     $animate.addClass($('#editUserForm'), 'shake').then(function(){$('#editUserForm').removeClass('shake');} );
  //     $event.preventDefault();
  //   }
  // }

  $scope.otherLEA = function(arg){
    $scope.other_lea = arg;
    $scope.other_placeholder = 'Please type in your District or CMO'
  }

  $scope.otherSchool = function(arg){
    $scope.other_school = arg;
    $scope.other_placeholder = 'Please type in your school'
  }

});
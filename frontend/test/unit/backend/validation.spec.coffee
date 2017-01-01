###

1 Correct request sending
  1.1 should send correct request when validating user

###

describe 'backend.validation', ->

  fakeAddress = 'fake_address'

  $httpBackend = null
  service      = null

  beforeEach ->
    module 'backend'

    angular.mock.module ($provide) ->
      $provide.constant 'BACKEND', fakeAddress

  beforeEach inject (_$httpBackend_, _validation_) ->
    $httpBackend = _$httpBackend_
    service      = _validation_

    $httpBackend.whenGET(/.*/).respond 200, {}
    $httpBackend.whenPOST(/.*/).respond 200, {}

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()



  describe '1 Correct request sending', ->

    it '1.1 should send correct request when validation user', ->
      $httpBackend.expectPOST fakeAddress + '/validate/user',
        userdata: null
        field: null

      service.validateUser null, null
      $httpBackend.flush()

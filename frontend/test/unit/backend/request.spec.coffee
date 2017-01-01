###

1 All request types
  1.1 should prefix request paths with pre-configured backend address

2 POST requests
  2.1 should send data

###

describe 'backend.request', ->

  fakeAddress = 'fake_address'

  $httpBackend = null
  service      = null

  beforeEach ->
    module 'backend'

    angular.mock.module ($provide) ->
      $provide.constant 'BACKEND', fakeAddress

  beforeEach inject (_$httpBackend_, _request_) ->
    $httpBackend = _$httpBackend_
    service      = _request_

    $httpBackend.whenGET(/.*/).respond 200, {}
    $httpBackend.whenPOST(/.*/).respond 200, {}

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()



  describe '1 All request types', ->

    it '1.1 should prefix request paths with pre-configured backend address', ->
      $httpBackend.expectGET fakeAddress + '/dummy'

      service.get 'dummy'
      $httpBackend.flush()



  describe '2 POST requests', ->

    it '2.1 should send data', ->
      $httpBackend.expectPOST fakeAddress + '/dummy', data: 'dummy data'

      service.post 'dummy', data: 'dummy data'
      $httpBackend.flush()

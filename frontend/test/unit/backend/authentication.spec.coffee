###

1 Logging in
  1.1 should send correct request
  1.2 should save result to cookies if succeeded
  1.3 should not save result to cookies if failed

2 Logging out
  2.2 should remove the cookie token if already logged in
  2.3 should do nothing if not logged in

3 Checking status
  3.1 should return true if the cookie token is present
  3.2 should return false if the cookie token is not present

4 Signing up
  4.1 should send correct request

###

describe 'backend.authentication', ->

  fakeAddress  = 'fake_address'
  fakeToken    = 'auth-token'
  fakeResponse = {}

  noop = (param) ->

  $httpBackend = null
  $cookies     = null
  service      = null

  beforeEach ->
    module 'backend'

    angular.mock.module ($provide) ->
      $provide.constant 'BACKEND',    fakeAddress
      $provide.constant 'AUTH_TOKEN', fakeToken

    module
      $cookies:
        store: {}
        put: (key, value) -> this.store[key] = value
        get: (key) -> this.store[key]
        remove: (key) -> delete this.store[key]

  beforeEach inject (_$httpBackend_, _$cookies_, _authentication_) ->
    $httpBackend = _$httpBackend_
    $cookies     = _$cookies_
    service      = _authentication_

    fakeResponse.get  = $httpBackend.whenGET(/.*/)
    fakeResponse.post = $httpBackend.whenPOST(/.*/)
    fakeResponse.get.respond  200, {}
    fakeResponse.post.respond 200, {}

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

    $cookies.remove fakeToken



  describe '1 Logging in', ->

    it '1.1 should send correct request', ->
      $httpBackend.expectPOST fakeAddress + '/login', userdata: null

      service.logIn null
      $httpBackend.flush()



    it '1.2 should save result to cookies if succeeded', ->
      fakeResponse.post.respond 200, token: 'dummy token'
      expect($cookies.get fakeToken).toBeUndefined()

      service.logIn(null).then noop, noop
      $httpBackend.flush()

      expect($cookies.get fakeToken).toBe 'dummy token'



    it '1.3 should not save result to cookies if failed', ->
      fakeResponse.post.respond 400, {}
      expect($cookies.get fakeToken).toBeUndefined()

      service.logIn(null).then noop, noop
      $httpBackend.flush()

      expect($cookies.get fakeToken).toBeUndefined()



  describe '2 Logging out', ->

    it '2.2 should remove the cookie token if already logged in', ->
      $cookies.put fakeToken, 'dummy token'
      expect($cookies.get fakeToken).toBe 'dummy token'

      service.logOut()

      expect($cookies.get fakeToken).toBeUndefined()



    it '2.3 should do nothing if not logged in', ->
      expect($cookies.get fakeToken).toBeUndefined()

      service.logOut()

      expect($cookies.get fakeToken).toBeUndefined()



  describe '3 Checking status', ->

    it '3.1 should return true if the cookie token is present', ->
      expect($cookies.get fakeToken).toBeUndefined()

      $cookies.put fakeToken, 'dummy token'

      expect(service.isLoggedIn()).toBe true



    it '3.2 should return false if the cookie token is not present', ->
      expect($cookies.get fakeToken).toBeUndefined()

      expect(service.isLoggedIn()).toBe false


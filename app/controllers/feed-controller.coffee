Controller = require 'controllers/base/controller'
FeedPageView = require 'views/feed/feed-page-view'
SearchPageView = require 'views/search/page-view'
Collection = require 'models/base/collection'
User = require 'models/user'
config = require 'config'
UsersView = require 'views/user/users-view'
Post = require 'models/post'
FeedPostsView = require 'views/feed/feed-posts-view'

module.exports = class FeedController extends Controller
  show: (params) ->
    @view = new FeedPageView
    @users = new Collection null, model: User
    @users.url = "#{config.api.versionRoot}/users/"
    @view.subview 'users', new UsersView collection: @users, region: 'users'
    @users.fetch()

    @posts = new Collection null, model: Post
    @posts.url = "#{config.api.versionRoot}/posts/"
    @view.subview 'posts', new FeedPostsView collection: @posts, region: 'posts'
    @posts.fetch()

  search: (params) ->
    @view = new SearchPageView

    @posts = new Collection null, model: Post
    @posts.url = "#{config.api.versionRoot}/search"
    @view.subview 'posts', new FeedPostsView collection: @posts, region: 'posts'

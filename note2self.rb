require 'sinatra/base'
require 'vaadin/elements'
require 'active_record'
require 'digest'
require_relative 'notes'

class Note2Self < Sinatra::Base

  helpers Vaadin::ViewHelpers

  before do
    Encoding.default_external = Encoding::UTF_8
  end

  # shows a form for notes
  get '/' do
    erb :index
  end

  # shows a note
  # private note requires to log in
  get '/:note_id' do
    ActiveRecord::Base.establish_connection(
        adapter: 'sqlite3',
        database: 'notes.db'
    )
    (@note = Note.find_by(code: params[:note_id])) ? erb(:note) : 404
  end

  # submits a new note
  post '/' do

    note = Note.new(params[:note])
    note.created_at = Time.now
    note.visible = true
    note.code = Digest::MD5.hexdigest([note.title, note.created_at.to_s, rand.to_s].join('::'))
    note.save ?
      redirect("/#{note.code}") :
      puts("error saving #{note.inspect}")
  end

  # shows user's view, requires the user to log in
  get '/self' do

  end

end
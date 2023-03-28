class ChatsController < ApplicationController

  def index
    @chats = Chat.all
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.save
    prompt = "You are a friendly assistant and you work for a programming school called RUNTEQ.
              Your job is to answer users' concerns and questions about the curriculum.
              For answers about the curriculum, please refer to the following websites:
              https://runteq.jp/blog/category/programming-school/gakusyu/
              https://note.com/hashtag/RUNTEQ
              Your favorite editor is Vim.
              You speak with a 'だぞ' at the end.
              "

    response = @client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          messages: [
                      { role: 'system', 'content': prompt},
                      { role: 'user', content: @query }
                    ],
          max_tokens: 60,
          n: 1,
          stop: '・'
      })

    @chats = response.dig("choices", 0, "message", "content")
  end

  # 入力したテキストに対して返答
  def search
    @query = params[:query]
    prompt = "You are a friendly assistant and you work for a programming school called RUNTEQ.
              Your job is to answer users' concerns and questions about the curriculum.
              For answers about the curriculum, please refer to the following websites:
              https://runteq.jp/blog/category/programming-school/gakusyu/
              https://note.com/hashtag/RUNTEQ
              Your favorite editor is Vim.
              You speak with a 'だぞ' at the end.
              "

    response = @client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          messages: [
                      { role: 'system', 'content': 'You are a helpful assistant.'},
                      { role: 'user', content: @query }
                    ],
          prompt: prompt,
          max_tokens: 60,
          n: 1,
          stop: '・'
      })

    @chats = response.dig("choices", 0, "message", "content")
  end
end

module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                articles = Article.order('created_at DESC')
                render json: {status: 'SUCCESS', message: 'Loaded Articles', data:articles}, status: :ok
            end

            def create
                article = Article.new(article_params)

                if article.save
                    render json: {status: 'SUCCESS', message: 'Save Article', data:article}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Something Went Wrong, Please Try Again...', data:article.errors}, status: :unprocessable_entity
                end
            end

            def show
                # Use show to return single items
                article = Article.find(params[:id])
                render json: {status: 'SUCCESS', message: 'Loaded Article', data:article}, status: :ok
            end

            def update
                article = Article.find(params[:id])
                if article.update_attributes(article_params)
                    render json: {status: 'SUCCESS', message: 'Article Updated', data:article}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Something Went Wrong, Please Try Again...', data:article.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                article = Article.find(params[:id])
                article.destroy()
                render json: {status: 'SUCCESS', message: 'Article Destroyed', data:article}, status: :ok
            end

            private 
            # White List article_params
            def article_params
                params.permit(:title, :body)
            end
        end
    end
end
class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
   layout false   
   include ApplicationHelper

   
   before_filter :redirect_to_other
    
  def index
    categories = Category.all
    @cat_results = Kaminari.paginate_array(categories).page(params[:page]).per(5)


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

  
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    
      if @category.save              
         flash[:cat_create_success] = "Category was successfully created."                     
         redirect_to :controller=>'categories', :action => 'index'                     
      else
                 render "categories/new"      
      end
   
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    
      if @category.update_attributes(params[:category])                   
         # render "categories/edit"
          flash[:cat_update_success] = "Category was successfully updated."                     
          redirect_to :controller=>'categories', :action => 'index'

      else
          render "categories/edit"           
      end
   
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

     redirect_to :controller=>'categories', :action => 'index'  
  end
end

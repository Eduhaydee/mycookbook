require 'rails_helper'

feature 'User delete recipe' do
  
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    # simula a ação do usuário
    visit root_path
    click_on recipe.title
    click_on 'Excluir'

    expect(page).to have_content('Receita deletada com sucesso')
    expect(page).to_not have_content('Bolo de cenoura')
    expect(Recipe.count).to eq 0
  end

  scenario 'Delete one specific recipe' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    recipe = Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                          recipe_type: recipe_type, cuisine: cuisine,
                          cook_time: 45,
                          ingredients: 'Farinha, açucar, chocolate',
                          cook_method: 'Corte o chocolate em pequenos pedaços, derreta e misture com o restante dos ingredientes')

    # simula a ação do usuário
    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Excluir'

    expect(page).to have_content('Receita deletada com sucesso')
    expect(page).to_not have_content('Bolo de cenoura')
    expect(page).to have_content('Bolo de chocolate')
    expect(Recipe.count).to eq 1
  end

end
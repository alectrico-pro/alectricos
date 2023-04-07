require "application_system_test_case"

class AutorizadosTest < ApplicationSystemTestCase
  setup do
    @autorizado = autorizados(:one)
  end

  test "visiting the index" do
    visit autorizados_url
    assert_selector "h1", text: "Autorizados"
  end

  test "creating a Autorizado" do
    visit autorizados_url
    click_on "New Autorizado"

    fill_in "Clase", with: @autorizado.clase
    fill_in "Comentario", with: @autorizado.comentario
    fill_in "Comuna", with: @autorizado.comuna
    fill_in "Desuscripcion token", with: @autorizado.desuscripcion_token
    fill_in "Direccion", with: @autorizado.direccion
    fill_in "Email", with: @autorizado.email
    fill_in "Fono", with: @autorizado.fono
    fill_in "Interes", with: @autorizado.interes
    fill_in "Nombre", with: @autorizado.nombre
    fill_in "Pedido adicional de informacion", with: @autorizado.pedido_adicional_de_informacion
    fill_in "Presentacion", with: @autorizado.presentacion
    fill_in "Reclutamiento", with: @autorizado.reclutamiento
    fill_in "Rut", with: @autorizado.rut
    fill_in "Suscripcion", with: @autorizado.suscripcion
    click_on "Create Autorizado"

    assert_text "Autorizado was successfully created"
    click_on "Back"
  end

  test "updating a Autorizado" do
    visit autorizados_url
    click_on "Edit", match: :first

    fill_in "Clase", with: @autorizado.clase
    fill_in "Comentario", with: @autorizado.comentario
    fill_in "Comuna", with: @autorizado.comuna
    fill_in "Desuscripcion token", with: @autorizado.desuscripcion_token
    fill_in "Direccion", with: @autorizado.direccion
    fill_in "Email", with: @autorizado.email
    fill_in "Fono", with: @autorizado.fono
    fill_in "Interes", with: @autorizado.interes
    fill_in "Nombre", with: @autorizado.nombre
    fill_in "Pedido adicional de informacion", with: @autorizado.pedido_adicional_de_informacion
    fill_in "Presentacion", with: @autorizado.presentacion
    fill_in "Reclutamiento", with: @autorizado.reclutamiento
    fill_in "Rut", with: @autorizado.rut
    fill_in "Suscripcion", with: @autorizado.suscripcion
    click_on "Update Autorizado"

    assert_text "Autorizado was successfully updated"
    click_on "Back"
  end

  test "destroying a Autorizado" do
    visit autorizados_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Autorizado was successfully destroyed"
  end
end

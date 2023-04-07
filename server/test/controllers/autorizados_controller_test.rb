require 'test_helper'

class AutorizadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @autorizado = autorizados(:one)
  end

  test "should get index" do
    get autorizados_url
    assert_response :success
  end

  test "should get new" do
    get new_autorizado_url
    assert_response :success
  end

  test "should create autorizado" do
    assert_difference('Autorizado.count') do
      post autorizados_url, params: { autorizado: { clase: @autorizado.clase, comentario: @autorizado.comentario, comuna: @autorizado.comuna, desuscripcion_token: @autorizado.desuscripcion_token, direccion: @autorizado.direccion, email: @autorizado.email, fono: @autorizado.fono, interes: @autorizado.interes, nombre: @autorizado.nombre, pedido_adicional_de_informacion: @autorizado.pedido_adicional_de_informacion, presentacion: @autorizado.presentacion, reclutamiento: @autorizado.reclutamiento, rut: @autorizado.rut, suscripcion: @autorizado.suscripcion } }
    end

    assert_redirected_to autorizado_url(Autorizado.last)
  end

  test "should show autorizado" do
    get autorizado_url(@autorizado)
    assert_response :success
  end

  test "should get edit" do
    get edit_autorizado_url(@autorizado)
    assert_response :success
  end

  test "should update autorizado" do
    patch autorizado_url(@autorizado), params: { autorizado: { clase: @autorizado.clase, comentario: @autorizado.comentario, comuna: @autorizado.comuna, desuscripcion_token: @autorizado.desuscripcion_token, direccion: @autorizado.direccion, email: @autorizado.email, fono: @autorizado.fono, interes: @autorizado.interes, nombre: @autorizado.nombre, pedido_adicional_de_informacion: @autorizado.pedido_adicional_de_informacion, presentacion: @autorizado.presentacion, reclutamiento: @autorizado.reclutamiento, rut: @autorizado.rut, suscripcion: @autorizado.suscripcion } }
    assert_redirected_to autorizado_url(@autorizado)
  end

  test "should destroy autorizado" do
    assert_difference('Autorizado.count', -1) do
      delete autorizado_url(@autorizado)
    end

    assert_redirected_to autorizados_url
  end
end

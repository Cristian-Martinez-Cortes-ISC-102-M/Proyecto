<?php

namespace App\Controllers;

use App\Models\UserModel;

class Home extends BaseController
{
    public function admin()
    {
        return view('admin');
    }
    public function index()
    {
        return view('index');
    }

    public function login()
    {
        $username = $this->request->getPost('username');
        $password = $this->request->getPost('password');

        $userModel = new UserModel();
        $user = $userModel->where('login_user', $username)
                         ->where('login_pass', $password)
                         ->first();

        if ($user) {
            // Usuario encontrado, redireccionar según el rol
            switch ($user['login_rol']) {
                case 'administrador':
                    return redirect()->to('/admin');
                    break;
                case 'docente':
                    return redirect()->to('/docente');
                    break;
                case 'alumno':
                    return redirect()->to('/alumno');
                    break;
                default:
                    return redirect()->back()->with('error', 'Rol de usuario desconocido');
            }
        } else {
            // Usuario no encontrado, mostrar mensaje de error
            return redirect()->back()->with('error', 'Credenciales inválidas');
        }
    }
}

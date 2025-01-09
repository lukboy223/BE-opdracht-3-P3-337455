<?php

class Homepages extends BaseController
{

    public function index()
    {
        $data = [
            'title' => 'Dit is de homepage!',
        ];

        $this->view('homepages/index', $data);
    }
}
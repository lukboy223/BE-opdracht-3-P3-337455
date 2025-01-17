<?php

class Leveranciers extends BaseController
{
    private $leverancierModel;

    public function __construct()
    {
        $this->leverancierModel = $this->model('Leverancier');
    }
    public function index($page = 1, $error = null)
    {
        $itemsPerPage = 4; // Number of items per page
        $offset = ($page - 1) * $itemsPerPage;

        if (!is_null($error)) {
            $color = 'alert-danger';
            $visibility = 'flex';
        } else {
            $color = '';
            $visibility = '';
        }

        $data = [
            'Magazijn'              => null,
            'message'               => $error,
            'messageColor'          => $color,
            'messageVisibility'     => $visibility,
            'currentPage'           => $page,
            'itemsPerPage'          => $itemsPerPage
        ];

        $data['Leveranciers'] = $this->leverancierModel->LeverancierOverzicht($offset, $itemsPerPage);
        $data['totalItems'] = $this->leverancierModel->getTotalLeveranciers();

        $this->view('leveranciers/index', $data);
    }

    public function viewProducts(int $leverancierId)
    {

        $products = $this->leverancierModel->ReadProductLeverancierByLevId($leverancierId);
        $LeverancierInfo = $this->leverancierModel->ReadLeverancierById($leverancierId);

        if (empty($products)) {

            $productsData = $products;
            $message = 'Dit bedrijf heeft tot nu toe geen producten geleverd aan Jamin';
            $messageColor = 'alert-danger';
            $messageVisibility = 'flex';
            header('Refresh:3;' .  URLROOT . '/leveranciers/index');
        } else {
            $productsData = $products;
            $message = '';
            $messageColor = '';
            $messageVisibility = '';
        }
        $data = [
            "LeverancierNaam"       => $LeverancierInfo->LeverancierNaam,
            "ContactPersoon"        => $LeverancierInfo->ContactPersoon,
            "LeverancierNummer"     => $LeverancierInfo->LeverancierNummer,
            "Mobiel"                => $LeverancierInfo->Mobiel,
            "Products"              => $productsData,
            'message'               => $message,
            'messageColor'          => $messageColor,
            'messageVisibility'     => $messageVisibility
        ];
        $this->view('leveranciers/view', $data);
    }

    public function AddLevering(int $productId = null)
    {
        if (is_null($productId)) {
            $DBdata = $this->leverancierModel->ReadProductLeverancierByProId($_POST['productId']);
        } else {
            $DBdata = $this->leverancierModel->ReadProductLeverancierByProId($productId);
        }
        if (empty($DBdata)) {
            $this->index('Product niet gevonden');
        } else if ($DBdata[0]->isActief == 0) {
            $this->index('Dit product wordt niet meer geleverd');
        } else {

            $data = [
                'PPLId'                 => $DBdata[0]->PPLId,
                'ProductNaam'           => $DBdata[0]->ProductNaam,
                'LeverancierNaam'       => $DBdata[0]->LeverancierNaam,
                'ContactPersoon'        => $DBdata[0]->ContactPersoon,
                'LeverancierNummer'     => $DBdata[0]->LeverancierNummer,
                'Mobiel'                => $DBdata[0]->Mobiel,
                'aantalLev'             => '',
                'aantalLevError'        => '',
                'datumLev'              => '',
                'datumLevError'         => '',
                'message'               => '',
                'messageColor'          => '',
                'messageVisibility'     => '',
                'productId'             => null
            ];
            if (is_null($productId)) {
                $data['productId'] = $_POST['productId'];
            } else {
                $data['productId'] = $productId;
            }

            if ($_SERVER['REQUEST_METHOD'] == 'POST') {

                $_POST = filter_input_array(INPUT_POST, FILTER_SANITIZE_FULL_SPECIAL_CHARS);

                $data['aantalLev'] = trim($_POST['aantalLev']);
                $data['datumLev'] = trim($_POST['datumLev']);

                $data = $this->AddLeveringValidation($data);

                if (
                    empty($data['aantalLevError']) &&
                    empty($data['datumLevError'])
                ) {
                    $ModelData = [
                        'PPLId'         => $data['PPLId'],
                        'DatumLev'      => $data['datumLev'],
                        'AantalLev'     => $data['aantalLev']
                    ];

                    $this->leverancierModel->UpdateLeverancierPerProduct($ModelData);
                    header('Location:' . URLROOT . '/leveranciers/index');
                } else {
                    $this->view('leveranciers/create', $data);
                }
            } else {
                $this->view('leveranciers/create', $data);
            }
        }
    }

    public function AddLeveringValidation($data)
    {
        if (empty($data['aantalLev'])) {
            $data['aantalLevError'] = 'Vul het aantal in';
        } elseif (!is_numeric($data['aantalLev'])) {
            $data['aantalLevError'] = 'Vul een geldig getal in';
        }
        if (empty($data['datumLev'])) {
            $data['datumLevError'] = 'Vul de datum in';
        } elseif (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $data['datumLev'])) {
            $data['datumLevError'] = 'Vul een geldige datum in';
        }
        return $data;
    }

    public function edit($page = 1, $message = null, $error = false)
    {
        $itemsPerPage = 4; // Number of items per page
        $offset = ($page - 1) * $itemsPerPage;

        if (!is_null($message)) {
            if($error == true){

                $color = 'alert-danger';
            }else{
                $color = 'alert-success';
            }
            $visibility = 'flex';
        } else {
            $color = '';
            $visibility = '';
        }

        $data = [
            'Magazijn'              => null,
            'message'               => $message,
            'messageColor'          => $color,
            'messageVisibility'     => $visibility,
            'currentPage'           => $page,
            'itemsPerPage'          => $itemsPerPage
        ];

        $data['Leveranciers'] = $this->leverancierModel->LeverancierOverzicht($offset, $itemsPerPage);
        $data['totalItems'] = $this->leverancierModel->getTotalLeveranciers();

        $this->view('leveranciers/edit', $data);
    }

    public function updateLeverancier(int $leverancierId)
    {
        $leverancier = $this->leverancierModel->ReadLeverancierById($leverancierId);


        if (empty($leverancier)) {
            $this->edit(1, 'Leverancier niet gevonden');
        } else {

            $data = [
                'LeverancierId'         => $leverancier->Id,
                'LeverancierNaam'       => $leverancier->LeverancierNaam,
                'ContactPersoon'        => $leverancier->ContactPersoon,
                'LeverancierNummer'     => $leverancier->LeverancierNummer,
                'Mobiel'                => $leverancier->Mobiel,
                'ContactId'             => $leverancier->ContactId,
                'Straat'                => '',
                'Huisnummer'            => '',
                'Postcode'              => '',
                'Stad'                  => '',
                'NaamError'             => '',
                'ContactPersoonError'   => '',
                'LeverancierNummerError'=> '',
                'MobielError'           => '',
                'StraatError'           => '',
                'HuisnummerError'       => '',
                'PostcodeError'         => '',
                'StadError'             => '',
                'message'               => '',
                'messageColor'          => '',
                'messageVisibility'     => ''
            ];

            $contact = $this->leverancierModel->ReadContactById($leverancier->ContactId);
            if (!empty($contact)) {
                $data['Straat'] = $contact->Straat;
                $data['Huisnummer'] = $contact->Huisnummer;
                $data['Postcode'] = $contact->Postcode;
                $data['Stad'] = $contact->Stad;
            }else{
                $this->edit(1, 'Kan leverancier contact informatie niet opvragen, probeer het later opnieuw', true);
            }
          

            if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                $_POST = filter_input_array(INPUT_POST, FILTER_SANITIZE_FULL_SPECIAL_CHARS);

                $data['LeverancierNaam']    = trim($_POST['LeverancierNaam']);
                $data['ContactPersoon']     = trim($_POST['ContactPersoon']);
                $data['LeverancierNummer']  = trim($_POST['LeverancierNummer']);
                $data['Mobiel']             = trim($_POST['Mobiel']);

                $data = $this->updateLeverancierValidation($data);

                if (
                    empty($data['LeverancierNaamError'])    &&
                    empty($data['ContactPersoonError'])     &&
                    empty($data['LeverancierNummerError'])  &&
                    empty($data['MobielError'])             &&
                    empty($data['StraatError'])             &&
                    empty($data['HuisnummerError'])         &&
                    empty($data['PostcodeError'])           &&
                    empty($data['StadError'])
                ) {
                    $ModelData = [
                        'LeverancierId'     => $data['LeverancierId'],
                        'LeverancierNaam'   => $data['LeverancierNaam'],
                        'ContactPersoon'    => $data['ContactPersoon'],
                        'LeverancierNummer' => $data['LeverancierNummer'],
                        'Mobiel'            => $data['Mobiel'],
                        'ContactId'         => $data['ContactId'],
                        'Straat'            => $data['Straat'],
                        'Huisnummer'        => $data['Huisnummer'],
                        'Postcode'          => $data['Postcode'],
                        'Stad'              => $data['Stad'],
                    ];
                    $dataUpdate = $this->leverancierModel->UpdateLeverancier($ModelData);
                    if($dataUpdate == false){
                        $this->edit(1, 'Leverancier niet succesvol geupdate, probeer het later opnieuw', true);
                    }else{
                        $this->edit(1, 'Leverancier succesvol geupdate', false);
                    }
                } else {
                    $this->view('leveranciers/update', $data);
                }
            } else {
                $this->view('leveranciers/update', $data);
            }
        }
    }

    public function updateLeverancierValidation($data)
    {
        if (empty($data['LeverancierNaam'])) {
            $data['LeverancierNaamError'] = 'Vul de naam in';
        }
        if (empty($data['ContactPersoon'])) {
            $data['ContactPersoonError'] = 'Vul de contact persoon in';
        }
        if (empty($data['LeverancierNummer'])) {
            $data['LeverancierNummerError'] = 'Vul het leverancier nummer in';
        }
        if (empty($data['Mobiel'])) {
            $data['MobielError'] = 'Vul het mobiel nummer in';
        }
        if (empty($data['Straat'])) {
            $data['StraatError'] = 'Vul de straat in';
        }
        if (empty($data['Huisnummer'])) {
            $data['HuisnummerError'] = 'Vul het huisnummer in';
        }
        if (empty($data['Postcode'])) {
            $data['PostcodeError'] = 'Vul de postcode in';
        }
        if (empty($data['Stad'])) {
            $data['StadError'] = 'Vul de stad in';
        }
        return $data;
    }
}

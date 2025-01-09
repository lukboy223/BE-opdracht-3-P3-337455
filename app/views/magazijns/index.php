<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <div class="row mt-3" style="display: <?= $data['messageVisibility'] ?>;">
        <div class="col-2"></div>
        <div class="col-8">
            <div class="alert text-center <?= $data['messageColor'] ?>" role="alert">
                <?= $data['message']; ?>
            </div>
            <div class="col-2"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
            <h3>Magazijn Jamil</h3>
        </div>
        <div class="col-2"></div>
    </div>


    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Naam</th>
                        <th>Barcode</th>
                        <th>Verpakings inhoud in kilogram</th>
                        <th>Aantal aanwezig</th>
                        <th>Leverancier Informatie</th>
                        <th>Allergenen Informatie</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    if(is_null($data['Magazijn'])){
                        echo "
                        <tr>
                            <td colspan='7' class='text-center'>
                            No rows found!
                            </td>
                        </tr>
                        ";
                    }else{
                        foreach ($data['Magazijn'] as $Product) {
                            echo "<tr>
                            <td>{$Product->Naam}</td>
                            <td>{$Product->Barcode}</td>
                            <td>{$Product->VerpakingsInhoudKilogram}</td>
                            <td>{$Product->AantalAanwezig}</td>
                            <td><a href='" . URLROOT . "/Magazijns/viewLeverancier/{$Product->Id}/{$Product->AantalAanwezig}'> <i class='bi bi-question-circle-fill'></i></td>
                            <td><a href='" . URLROOT . "/Magazijns/viewAllergenen/{$Product->Id}'> <i class='bi bi-x-lg'></i></i></td>
                            </tr>";
                        }
                    }
                    ?>
                </tbody>
            </table>
            <a href="<?= URLROOT; ?>/homepages/index">Homepage</a>
        </div>
        <div class="col-2"></div>
    </div>
</div>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>
<!-- <td>
<a href='" . URLROOT . "/countries/update/{$country->Id}'>
<i class='bi bi-pencil-square'></i>
</a>
</td>
<td>
<a href='" . URLROOT . "/countries/delete/{$country->Id}'>
<i class='bi bi-trash'></i>
</a>
</td>             -->
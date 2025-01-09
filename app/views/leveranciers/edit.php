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
            <h3>Leverancier overzicht</h3>
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
                        <th>Contact persoon</th>
                        <th>Leverancier nummer</th>
                        <th>Mobiel</th>
                        <th>wijzigen</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    if(is_null($data['Leveranciers'])){
                        echo "
                        <tr>
                            <td colspan='7' class='text-center'>
                            No rows found!
                            </td>
                        </tr>
                        ";
                    }else{
                        foreach ($data['Leveranciers'] as $Leverancier) {
                            echo "<tr>
                            <td>{$Leverancier->LeverancierNaam}</td>
                            <td>{$Leverancier->ContactPersoon}</td>
                            <td>{$Leverancier->LeverancierNummer}</td>
                            <td>{$Leverancier->Mobiel}</td>
                            <td><a href='" . URLROOT . "/Leveranciers/updateLeverancier/{$Leverancier->LeverancierId}'> <i class='bi bi-pencil'></i></td>
                           
                            </tr>";
                        }
                    }
                    ?>
                </tbody>
            </table>

            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <?php
                    $totalPages = ceil($data['totalItems'] / $data['itemsPerPage']);
                    for ($i = 1; $i <= $totalPages; $i++) {
                        $active = $i == $data['currentPage'] ? 'active' : '';
                        echo "<li class='page-item $active'><a class='page-link' href='" . URLROOT . "/Leveranciers/edit/$i'>$i</a></li>";
                    }
                    ?>
                </ul>
            </nav>
            
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